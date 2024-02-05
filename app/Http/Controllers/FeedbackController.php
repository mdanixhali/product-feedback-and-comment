<?php

namespace App\Http\Controllers;

use App\Http\Requests\FeedbackRequest;
use App\Models\Feedback;
use Illuminate\Support\Facades\DB;


class FeedbackController extends Controller
{

    protected $perPage = 10;
    public function index(){
        $nextOffset = $this->nextOffset(request()->page, $this->perPage);
        $userId = auth()->user()->id;
        return Feedback::with('user:id,name')->where('user_id', $userId)->orderBy('created_at', 'DESC')->offset($nextOffset)->paginate($this->perPage);
    }

    public function store(FeedbackRequest $request)
    {
        DB::beginTransaction();
        try {
            Feedback::create($request->validated());
            DB::commit();
            return response()->json([
                'success' => true,
                'message' => 'Submitted successfully.',
            ]);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => true,
                'message' => 'Something went wrong. refresh the page and Please try again.',
            ]);
        }
    }

    public function show($id){
        $userId = auth()->user()->id;
        return Feedback::with(['user:id,name', 'comments', 'comments.user:id,name'])
        ->where('id', $id)
        ->where('user_id', $userId)
        ->first();
    }

    public function destroy($id){
        DB::beginTransaction();
        try {
            $feedback = Feedback::find($id);
            $feedback->comments()->delete();
            $feedback->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Deleted successfully.',
            ]);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => true,
                'message' => 'Something went wrong. Please refresh the page and try again.',
            ]);
        }
    }

    protected function nextOffset($currentPage, $perPage){

        $currentPage = max(1, intval($currentPage));
        $perPage = max(1, intval($perPage));
        
        $nextOffset = ($currentPage - 1) * $perPage;
        
        return $nextOffset;
    }
}

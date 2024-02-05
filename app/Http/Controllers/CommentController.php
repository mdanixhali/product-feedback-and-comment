<?php

namespace App\Http\Controllers;

use App\Http\Requests\CommentRequest;
use App\Models\Comment;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class CommentController extends Controller
{
    
    public function store(CommentRequest $request){
        DB::beginTransaction();
        try {
            $comment = Comment::create($request->validated());
            $comment = $comment->refresh();
            DB::commit();
            return response()->json([
                'success' => true,
                'comment' => $comment,
                'message' => 'Submitted successfully.',
            ]);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => true,
                'message' => 'Something went wrong. Please refresh the page and try again.',
            ]);
        }
    }

    public function show($feedbackId){
        $userId = auth()->user()->id;
        $comments = Comment::with('user:id,name')
        ->where('feedback_id', $feedbackId)
        ->where('user_id', $userId)
        ->orderBy('created_at', 'DESC')
        ->get();
        return response()->json($comments);
    }

    public function update(CommentRequest $request, Comment $comment){
        DB::beginTransaction();
        try {
            $comment->comment = $request->comment;
            $comment->update();
            DB::commit();
            return response()->json([
                'success' => true,
                'comment' => $comment,
                'message' => 'Updated successfully.',
            ]);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => true,
                'message' => 'Something went wrong. Please refresh the page and try again.',
            ]);
        }
    }

    public function destroy($id){
        DB::beginTransaction();
        try {
            $comment = Comment::find($id);
            $comment->delete();
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

    public function getUsers(){
        $keyword = request()->get('keyword');
        $users = User::select('id', 'name')->where('name', 'like', $keyword . '%')->limit(10)->get();
        return response()->json($users);
    }
}

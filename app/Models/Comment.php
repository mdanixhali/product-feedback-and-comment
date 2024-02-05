<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Feedback;
use App\Models\User;

class Comment extends Model
{
    use HasFactory;

    protected $table = 'comments';
    protected $fillable = [
        'comment',
        'feedback_id',
        'user_id',
    ];

    public function feedback(){
        return $this->belongsTo(Feedback::class);
    }
    public function user(){
        return $this->belongsTo(User::class);
    }

    public function getCreatedAtAttribute($value){
        return \Carbon\Carbon::parse($value)->format('d M Y');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Notification extends Model
{
    use HasFactory;

    protected $table = 'notification';

    protected $primaryKey = 'notificationID';

    public $incrementing = true;

    protected $keyType = 'int';

    protected $fillable = [
        'userID',
        'title',
        'description',
        'status',
    ];
}

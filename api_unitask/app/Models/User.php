<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Report extends Model
{
    use HasFactory;

    protected $table = 'reports'; 

    protected $primaryKey = 'report_id'; 

    public $incrementing = true; 

    protected $fillable = [
        'folio',
        'buildingID',
        'room_id',
        'category_id',
        'good_id',
        'attention_level',
        'description',
        'image',
        'reported_by',
        'status_id',
        'requires_approval',
        'involve_third_parties',
    ];

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($report) {
            $report->folio = strtoupper(Str::random(rand(6, 7))); 
        });
    }

    public function building()
    {
        return $this->belongsTo(Building::class, 'buildingID', 'buildingID');
    }

    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id', 'room_id');
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'category_id');
    }

    public function good()
    {
        return $this->belongsTo(Good::class, 'good_id', 'good_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'reported_by', 'user_id');
    }

    public function status()
    {
        return $this->belongsTo(Status::class, 'status_id', 'status_id');
    }
}

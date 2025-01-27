<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $table = 'categories'; 

    protected $primaryKey = 'categoryID'; 

    public $timestamps = true; 

    protected $fillable = [
        'name',
    ];

    public function goods()
    {
        return $this->hasMany(Good::class, 'categoryID', 'categoryID');
    }
}

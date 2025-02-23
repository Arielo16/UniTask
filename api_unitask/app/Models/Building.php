<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Building extends Model
{
    use HasFactory;

    protected $table = 'buildings';

    protected $primaryKey = 'buildingID'; 

    public $incrementing = true; 
    
    protected $fillable = [
        'buildingID',
        'name',
        'keyID',
    ];

    public function rooms()
    {
        return $this->hasMany(Room::class, 'buildingID', 'buildingID');
    }
}

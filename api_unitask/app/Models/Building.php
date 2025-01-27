<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Building extends Model
{
    use HasFactory;

    protected $table = 'buildings';

    protected $primaryKey = 'buildingID'; 

    public $incrementing = false; // Indico que la llave primaria no es incremental

    protected $keyType = 'string'; // Tipo de la llave primaria
    
    protected $fillable = ['buildingID']; // Columnas asignables en masa


    public function rooms()
    {
        return $this->hasMany(Room::class, 'buildingID', 'buildingID');
    }
}

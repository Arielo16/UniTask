<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    use HasFactory;

    protected $table = 'rooms'; // Nombre de la tabla

    public $incrementing = false; // Desactiva el autoincremento (por la llave compuesta)

    protected $primaryKey = ['roomID', 'buildingID']; // Llave primaria compuesta

    public $timestamps = true; // Las columnas created_at y updated_at están activas

    protected $fillable = [
        'roomID',
        'buildingID',
        'typeID',
    ]; // Campos que se pueden asignar masivamente

    /**
     * Relación con el edificio (building).
     */
    public function building()
    {
        return $this->belongsTo(Building::class, 'buildingID', 'buildingID');
    }

    /**
     * Relación con el tipo (type).
     */
    public function type()
    {
        return $this->belongsTo(Type::class, 'typeID', 'typeID');
    }
}

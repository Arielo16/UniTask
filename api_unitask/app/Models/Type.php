<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Type extends Model
{
    use HasFactory;

    protected $table = 'types'; // Nombre de la tabla

    protected $primaryKey = 'typeID'; // Llave primaria

    public $incrementing = true; // Incremento automático habilitado

    protected $fillable = [
        'name',
    ]; // Campos asignables en masa

    /**
     * Relación con otros modelos si es necesario.
     */
    // public function rooms()
    // {
    //     return $this->hasMany(Room::class, 'typeID', 'typeID');
    // }
}

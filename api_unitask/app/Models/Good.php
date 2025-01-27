<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Good extends Model
{
    use HasFactory;

    // Se Especifica la tabla asociada al modelo
    protected $table = 'goods';

    // Especificamos la clave primaria 
    protected $primaryKey = 'goodID';

    // Indicar si la clave primaria es incremental (si no es de tipo bigint autoincremental)
    public $incrementing = true;

    // Especificar el tipo de la clave primaria
    protected $keyType = 'int';

    // Habilitar o deshabilitar timestamps (Se pone de defecto)
    public $timestamps = true;

    // Asignación de compos 
    protected $fillable = [
        'name',         // Nombre del bien
        'categoryID',   // Llave foránea de la categoría
    ];

    // Especificaciones de las relaciones
    public function category()
    {
        return $this->belongsTo(Category::class, 'categoryID', 'categoryID');
    }
}

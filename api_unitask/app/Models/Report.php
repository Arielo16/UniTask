<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Report extends Model
{
    use HasFactory;

    // Tabla asociada
    protected $table = 'reports';

    // Llave primaria
    protected $primaryKey = 'folio';

    // Desactivamos el incremento automático porque usamos un string como llave primaria
    public $incrementing = false;

    // Tipo de la llave primaria
    protected $keyType = 'string';

    // Campos asignables
    protected $fillable = [
        'folio',
        'buildingID',
        'roomID',
        'categoryID',
        'goodID', 
        'priority',
        'description',
        'image',
        'matricula',
        'status',
    ];

    // Relaciones
    public function building()
    {
        return $this->belongsTo(Building::class, 'buildingID', 'buildingID');
    }

    public function room()
    {
        return $this->belongsTo(Room::class, 'roomID', 'roomID');
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'categoryID', 'categoryID');
    }

    public function goods()
    {
        return $this->belongsTo(Goods::class, 'goodID', 'goodID'); 
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'matricula', 'matricula');
    }
}

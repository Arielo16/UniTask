<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Diagnostic extends Model
{
    use HasFactory;

    protected $table = 'diagnostics'; // Nombre de la tabla

    protected $primaryKey = 'diagnosticID'; // Llave primaria

    public $timestamps = true; // Activa las columnas created_at y updated_at

    protected $fillable = [
        'folio',
        'description',
        'images',
        'completed',
    ]; // Campos asignables en masa

    protected $casts = [
        'images' => 'array', // Convierte el JSON de imágenes en un array
        'completed' => 'boolean', // El campo 'completed' se maneja como booleano
    ];

    /**
     * Relación con el reporte (report).
     */
    public function report()
    {
        return $this->belongsTo(Report::class, 'folio', 'folio');
    }
}

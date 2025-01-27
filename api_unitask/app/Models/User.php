<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use HasFactory;

    protected $table = 'users'; // Nombre de la tabla

    protected $primaryKey = 'matricula'; // Cambiar la llave primaria a "matricula"

    public $incrementing = false; // Deshabilitar incremento automático para la llave primaria

    protected $keyType = 'string'; // Tipo de la llave primaria

    protected $fillable = [
        'matricula',
        'first_name',
        'last_name',
        'middle_name',
        'institutional_email',
        'password',
        'birth_date',
    ]; // Campos asignables en masa

    protected $hidden = [
        'password',
        'remember_token',
    ]; // Ocultar estos campos en serializaciones JSON

    protected $casts = [
        'birth_date' => 'date',
    ]; // Casting del campo birth_date

    /**
     * Relación con otros modelos si es necesario.
     */
    // Ejemplo:
    // public function reports()
    // {
    //     return $this->hasMany(Report::class, 'matricula', 'matricula');
    // }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Material extends Model
{
    use HasFactory;

    protected $table = 'materials'; 

    protected $primaryKey = 'materialID'; 

    protected $fillable = [
        'name',
        'supplier',
        'quantity',
        'price',
        'diagnosis_id',
    ];

    public function diagnostic()
    {
        return $this->belongsTo(Diagnostic::class, 'diagnosis_id', 'diagnosis_id');
    }
}

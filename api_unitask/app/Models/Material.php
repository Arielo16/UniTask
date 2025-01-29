<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Material extends Model
{
    use HasFactory;

    protected $table = 'materials'; 

    protected $primaryKey = 'material_id'; 

    protected $fillable = [
        'name',
        'supplier',
        'quantity',
        'price',
        'diagnosis_id',
    ];

    public function diagnosis()
    {
        return $this->belongsTo(Diagnosis::class, 'diagnosis_id', 'diagnosis_id');
    }
}

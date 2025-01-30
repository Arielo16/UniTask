<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Status extends Model
{
    use HasFactory;

    protected $table = 'statuses';

    protected $primaryKey = 'statusID';

    public $incrementing = true;

    protected $keyType = 'int';

    protected $fillable = [
        'statusID',
        'name',
    ];

    public function reports()
    {
        return $this->hasMany(Report::class, 'statusID', 'statusID');
    }
}

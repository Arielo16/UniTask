<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Report extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'reports';

    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'folio';

    /**
     * Indicates if the IDs are auto-incrementing.
     *
     * @var bool
     */
    public $incrementing = false;

    /**
     * The data type of the primary key.
     *
     * @var string
     */
    protected $keyType = 'string';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'folio',
        'building_id',
        'room_id',
        'category_id',
        'priority',
        'description',
        'image',
        'created_by',
        'status',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'priority' => 'string',
        'status' => 'string',
    ];

    /**
     * Relationships.
     */

    // Building relationship
    public function building()
    {
        return $this->belongsTo(Building::class, 'building_id', 'building_id');
    }

    // Room relationship
    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id', 'room_id');
    }

    // Category relationship
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'category_id');
    }

    // User relationship
    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by', 'user_id');
    }
}

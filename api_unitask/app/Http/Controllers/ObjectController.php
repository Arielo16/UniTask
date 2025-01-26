<?php

namespace App\Http\Controllers;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Http\Request;
use App\Models\Object;

class ObjectController extends Controller
{
    use HasFactory;
    public function index(){return Object::all();}
    public function nepe(){}



 




}

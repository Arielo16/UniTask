<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id('userID');
            $table->string('matricula')->unique(); 
            $table->string('name'); 
            $table->string('lastname'); 
            $table->string('secundlastname'); 
            $table->string('email')->unique(); 
            $table->string('password'); 
            $table->date('birthday');
            $table->timestamps(); 
        });
    }

    public function down()
    {
        Schema::dropIfExists('reports');
    }
};

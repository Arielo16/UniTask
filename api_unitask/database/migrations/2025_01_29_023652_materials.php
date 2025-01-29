<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('materials', function (Blueprint $table) {
            $table->id('material_id'); 
            $table->string('name'); 
            $table->string('supplier'); // Este es el proveedor
            $table->integer('quantity'); 
            $table->decimal('price', 10, 2); 
            $table->unsignedBigInteger('diagnosis_id'); 
            $table->timestamps();

            $table->foreign('diagnosis_id')->references('diagnosis_id')->on('diagnoses')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('materials');
    }
};

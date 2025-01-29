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
            $table->unsignedBigInteger('diagnosticID'); 
            $table->timestamps();

            $table->foreign('diagnosticID')->references('diagnosticID')->on('diagnostics')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('materials');
    }
};

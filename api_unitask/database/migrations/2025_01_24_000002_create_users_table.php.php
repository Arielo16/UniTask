<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('reports', function (Blueprint $table) {
            $table->id('reportID'); 
            $table->string('folio', 7)->unique(); 
            $table->string('buildingID', 10); 
            $table->string('roomID', 10); 
            $table->unsignedBigInteger('categoryID'); 
            $table->unsignedBigInteger('goodID'); 
            $table->enum('attention_level', ['Immediate', 'Normal']); 
            $table->text('description'); 
            $table->string('image')->nullable(); 
            $table->unsignedBigInteger('userID'); 
            $table->unsignedBigInteger('statusID'); 
            $table->boolean('requires_approval')->default(false); 
            $table->boolean('involve_third_parties')->default(false); 
            $table->timestamps(); 

            $table->foreign('buildingID')->references('buildingID')->on('buildings')->onDelete('cascade');
            $table->foreign('roomID')->references('roomID')->on('rooms')->onDelete('cascade');
            $table->foreign('categoryID')->references('categoryID')->on('categories')->onDelete('cascade');
            $table->foreign('goodID')->references('goodID')->on('goods')->onDelete('cascade');
            $table->foreign('userID')->references('user_id')->on('users')->onDelete('cascade');
            $table->foreign('statusID')->references('statusID')->on('statuses')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('reports');
    }
};

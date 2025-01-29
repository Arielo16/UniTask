<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('diagnostics', function (Blueprint $table) {
            $table->id('diagnosticID'); 
            $table->unsignedBigInteger('reportID');
            $table->text('description');
            $table->json('images');
            $table->enum('status', ['Enviado', 'EnviadoAprobacion', 'EnProceso', 'Terminado']);

            // Llave foránea
            $table->foreign('reportID')->references('reportID')->on('reports')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('diagnostics');
    }
};

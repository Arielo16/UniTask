<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('statuses', function (Blueprint $table) {
            $table->id('statusID');
            $table->string('name');
            $table->timestamps();
        });

        // Insertar datos en la tabla "statuses"
        DB::table('statuses')->insert([
            ['name' => 'Pending', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'In Progress', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Completed', 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Diagnostiqued', 'created_at' => now(), 'updated_at' => now()],
            // Agrega más datos según sea necesario
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('statuses');
    }
};

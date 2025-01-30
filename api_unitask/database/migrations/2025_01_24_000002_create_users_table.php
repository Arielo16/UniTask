<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

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

        // Insertar datos en la tabla "users"
        DB::table('users')->insert([
            [
                'matricula' => 'A12345678',
                'name' => 'John',
                'lastname' => 'Doe',
                'secundlastname' => 'Smith',
                'email' => 'johndoe@gmail.com',
                'password' => bcrypt('password123'),
                'birthday' => '1990-01-01',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'matricula' => 'B87654321',
                'name' => 'Jane',
                'lastname' => 'Doe',
                'secundlastname' => 'Johnson',
                'email' => 'janedoe@gmail.com',
                'password' => bcrypt('password123'),
                'birthday' => '1992-02-02',
                'created_at' => now(),
                'updated_at' => now()
            ],
            // Agrega más datos según sea necesario
        ]);
    }

    public function down()
    {
        Schema::dropIfExists('users');
    }
};

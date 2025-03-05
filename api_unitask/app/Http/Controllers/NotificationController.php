<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Notification;

class NotificationController extends Controller
{
    public function index(Request $request)
    {
        $notifications = Notification::all();
        return response()->json($notifications, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'userID' => 'required|integer|exists:users,userID',
            'title' => 'required|string|max:100',
            'description' => 'required|string',
            'status' => 'required|in:Enviado,Leído',
        ]);

        $notification = Notification::create($request->all());
        return response()->json($notification, 201);
    }

    public function show($notificationID)
    {
        $notification = Notification::findOrFail($notificationID);
        return response()->json($notification, 200);
    }

    public function update(Request $request, $notificationID)
    {
        $request->validate([
            'userID' => 'nullable|integer|exists:users,userID',
            'title' => 'nullable|string|max:100',
            'description' => 'nullable|string',
            'status' => 'nullable|in:Enviado,Leído',
        ]);

        $notification = Notification::findOrFail($notificationID);
        $notification->update($request->all());
        return response()->json($notification, 200);
    }
}

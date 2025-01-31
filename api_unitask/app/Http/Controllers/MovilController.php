<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Report;
use App\Models\Building;
use App\Models\Room;
use App\Models\Category;
use App\Models\Good;
use App\Models\User;
use App\Models\Status;
use Illuminate\Support\Facades\DB;
use App\Models\Diagnostic;

class MovilController extends Controller
{
    //

    public function getAllReports()
    {
        $reports = DB::table('reports')
            ->join('buildings', 'reports.buildingID', '=', 'buildings.buildingID')
            ->join('rooms', 'reports.roomID', '=', 'rooms.roomID')
            ->join('types', 'rooms.typeID', '=', 'types.typeID')
            ->join('categories', 'reports.categoryID', '=', 'categories.categoryID')
            ->join('goods', 'reports.goodID', '=', 'goods.goodID')
            ->join('users', 'reports.userID', '=', 'users.userID')
            ->join('statuses', 'reports.statusID', '=', 'statuses.statusID')
            ->select(
                'reports.folio',
                'reports.buildingID',
                'buildings.name as building_name',
                'reports.roomID',
                'rooms.name as room_name',
                'rooms.key as room_key',
                'rooms.typeID',
                'types.name as type_name',
                'reports.categoryID',
                'categories.name as category_name',
                'reports.goodID',
                'goods.name as good_name',
                'reports.priority',
                'reports.description',
                'reports.image',
                'reports.userID',
                'users.name as user_name',
                'users.lastname as user_lastname',
                'reports.statusID',
                'statuses.name as status_name',
                'reports.requires_approval',
                'reports.involve_third_parties',
                'reports.created_at'
            )
            ->get();

        return response()->json($reports);
    }

    public function getAllDiagnostics()
    {
        $diagnostics = DB::table('diagnostics')
            ->join('reports', 'diagnostics.reportID', '=', 'reports.reportID')
            ->select(
                'diagnostics.diagnosticID',
                'diagnostics.reportID',
                'reports.folio as report_folio',
                'diagnostics.description',
                'diagnostics.images',
                'diagnostics.status',
                'diagnostics.created_at'
            )
            ->get();

        return response()->json($diagnostics);
    }

    public function getAllDiagnosticsStatus(Request $request)
    {
        $status = $request->status;

        $diagnostics = DB::table('diagnostics')
            ->join('reports', 'diagnostics.reportID', '=', 'reports.reportID')
            ->where('diagnostics.status', $status)
            ->select(
                'diagnostics.diagnosticID',
                'diagnostics.reportID',
                'reports.folio as report_folio',
                'diagnostics.description',
                'diagnostics.images',
                'diagnostics.status',
                'diagnostics.created_at'
            )
            ->get();

        return response()->json($diagnostics);
    }

    public function postDiagnostic(Request $request)
    {
        $validatedData = $request->validate([
            'reportID' => 'required|string',
            'description' => 'required|string',
            'images' => 'nullable|string',
            'status' => 'required|string',
        ]);

        $diagnostic = Diagnostic::create($validatedData);

        return response()->json($diagnostic, 201);
    }

    public function updateDiagnosticStatus(Request $request)
    {
        $validatedData = $request->validate([
            'id' => 'required|integer',
            'status' => 'required|string',
        ]);

        $diagnostic = Diagnostic::findOrFail($validatedData['id']);
        $diagnostic->status = $validatedData['status'];
        $diagnostic->save();

        return response()->json($diagnostic);
    }
}

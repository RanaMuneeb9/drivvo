# Diff Details

Date : 2025-12-29 17:48:53

Directory e:\\Development\\Multan\\Xtra App Studio\\3.35.4\\drivvo

Total : 109 files,  10070 codes, 531 comments, 645 blanks, all 11246 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [assets/lang/en\_US.json](/assets/lang/en_US.json) | JSON | 48 | 0 | 0 | 48 |
| [assets/lang/ur\_PK.json](/assets/lang/ur_PK.json) | JSON | 48 | 0 | 0 | 48 |
| [firestore.indexes.json](/firestore.indexes.json) | JSON | 20 | 0 | 0 | 20 |
| [lib/custom-widget/button/custom\_outline\_button.dart](/lib/custom-widget/button/custom_outline_button.dart) | Dart | 41 | 0 | 3 | 44 |
| [lib/custom-widget/reminder/custom\_toggle\_btn.dart](/lib/custom-widget/reminder/custom_toggle_btn.dart) | Dart | 42 | 0 | 5 | 47 |
| [lib/custom-widget/report/charts/category\_pie\_chart.dart](/lib/custom-widget/report/charts/category_pie_chart.dart) | Dart | 163 | 0 | 11 | 174 |
| [lib/custom-widget/report/charts/cost\_pie\_chart.dart](/lib/custom-widget/report/charts/cost_pie_chart.dart) | Dart | 224 | 0 | 9 | 233 |
| [lib/custom-widget/report/charts/distance\_per\_refueling\_line\_chart.dart](/lib/custom-widget/report/charts/distance_per_refueling_line_chart.dart) | Dart | 193 | 0 | 11 | 204 |
| [lib/custom-widget/report/charts/expense\_vs\_income\_bar\_chart.dart](/lib/custom-widget/report/charts/expense_vs_income_bar_chart.dart) | Dart | 198 | 7 | 12 | 217 |
| [lib/custom-widget/report/charts/fuel\_efficiency\_line\_chart.dart](/lib/custom-widget/report/charts/fuel_efficiency_line_chart.dart) | Dart | 93 | 0 | 5 | 98 |
| [lib/custom-widget/report/charts/fuel\_price\_line\_chart.dart](/lib/custom-widget/report/charts/fuel_price_line_chart.dart) | Dart | 187 | 0 | 9 | 196 |
| [lib/custom-widget/report/charts/monthly\_cost\_bar\_chart.dart](/lib/custom-widget/report/charts/monthly_cost_bar_chart.dart) | Dart | 164 | 0 | 11 | 175 |
| [lib/custom-widget/report/charts/odometer\_history\_line\_chart.dart](/lib/custom-widget/report/charts/odometer_history_line_chart.dart) | Dart | 193 | 0 | 11 | 204 |
| [lib/custom-widget/report/custom\_report\_card.dart](/lib/custom-widget/report/custom_report_card.dart) | Dart | 143 | 0 | 4 | 147 |
| [lib/custom-widget/report/distance\_report\_card.dart](/lib/custom-widget/report/distance_report_card.dart) | Dart | 105 | 0 | 4 | 109 |
| [lib/custom-widget/report/report\_date\_range.dart](/lib/custom-widget/report/report_date_range.dart) | Dart | 60 | 0 | 3 | 63 |
| [lib/custom-widget/report/report\_tab\_bar.dart](/lib/custom-widget/report/report_tab_bar.dart) | Dart | 47 | 0 | 4 | 51 |
| [lib/custom-widget/text-input-field/text\_input\_field.dart](/lib/custom-widget/text-input-field/text_input_field.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/model/app\_user.dart](/lib/model/app_user.dart) | Dart | 40 | -1 | 10 | 49 |
| [lib/model/expense/expense\_model.dart](/lib/model/expense/expense_model.dart) | Dart | -26 | -1 | -1 | -28 |
| [lib/model/general\_model.dart](/lib/model/general_model.dart) | Dart | 8 | 0 | 1 | 9 |
| [lib/model/income/income\_model.dart](/lib/model/income/income_model.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/model/refueling/refueling\_model.dart](/lib/model/refueling/refueling_model.dart) | Dart | 3 | 0 | 1 | 4 |
| [lib/model/reminders/reminder\_model.dart](/lib/model/reminders/reminder_model.dart) | Dart | 1 | 0 | 1 | 2 |
| [lib/model/route/route\_model.dart](/lib/model/route/route_model.dart) | Dart | 3 | 0 | 1 | 4 |
| [lib/model/service/service\_model.dart](/lib/model/service/service_model.dart) | Dart | 94 | 0 | 5 | 99 |
| [lib/model/timeline\_entry.dart](/lib/model/timeline_entry.dart) | Dart | 59 | 6 | 11 | 76 |
| [lib/model/vehicle/vehicle\_model.dart](/lib/model/vehicle/vehicle_model.dart) | Dart | 4 | 0 | 0 | 4 |
| [lib/modules/authentication/import-data/import\_data\_controller.dart](/lib/modules/authentication/import-data/import_data_controller.dart) | Dart | -4 | 0 | -1 | -5 |
| [lib/modules/authentication/login/login\_controller.dart](/lib/modules/authentication/login/login_controller.dart) | Dart | 60 | 0 | 7 | 67 |
| [lib/modules/authentication/signup/signup\_controller.dart](/lib/modules/authentication/signup/signup_controller.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/modules/home/expense/create/create\_expense\_binding.dart](/lib/modules/home/expense/create/create_expense_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/expense/create/create\_expense\_controller.dart](/lib/modules/home/expense/create/create_expense_controller.dart) | Dart | 148 | 1 | 28 | 177 |
| [lib/modules/home/expense/create/create\_expense\_view.dart](/lib/modules/home/expense/create/create_expense_view.dart) | Dart | 539 | 21 | 8 | 568 |
| [lib/modules/home/expense/create\_expense\_binding.dart](/lib/modules/home/expense/create_expense_binding.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/modules/home/expense/create\_expense\_controller.dart](/lib/modules/home/expense/create_expense_controller.dart) | Dart | -168 | 0 | -24 | -192 |
| [lib/modules/home/expense/create\_expense\_view.dart](/lib/modules/home/expense/create_expense_view.dart) | Dart | -533 | -4 | -8 | -545 |
| [lib/modules/home/expense/type/expense\_type\_controller.dart](/lib/modules/home/expense/type/expense_type_controller.dart) | Dart | 12 | 0 | 1 | 13 |
| [lib/modules/home/expense/type/expense\_type\_view.dart](/lib/modules/home/expense/type/expense_type_view.dart) | Dart | 9 | 0 | 0 | 9 |
| [lib/modules/home/expense/update/update\_expense\_binding.dart](/lib/modules/home/expense/update/update_expense_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/expense/update/update\_expense\_controller.dart](/lib/modules/home/expense/update/update_expense_controller.dart) | Dart | 171 | 3 | 31 | 205 |
| [lib/modules/home/expense/update/update\_expense\_view.dart](/lib/modules/home/expense/update/update_expense_view.dart) | Dart | 557 | 1 | 8 | 566 |
| [lib/modules/home/filter/home\_filter\_controller.dart](/lib/modules/home/filter/home_filter_controller.dart) | Dart | 13 | -1 | 1 | 13 |
| [lib/modules/home/filter/home\_filter\_view.dart](/lib/modules/home/filter/home_filter_view.dart) | Dart | -7 | 14 | 0 | 7 |
| [lib/modules/home/home\_controller.dart](/lib/modules/home/home_controller.dart) | Dart | 376 | 43 | 43 | 462 |
| [lib/modules/home/home\_view.dart](/lib/modules/home/home_view.dart) | Dart | 407 | 55 | 8 | 470 |
| [lib/modules/home/home\_view\_copy.dart](/lib/modules/home/home_view_copy.dart) | Dart | 941 | 66 | 30 | 1,037 |
| [lib/modules/home/income/create/create\_income\_binding.dart](/lib/modules/home/income/create/create_income_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/income/create/create\_income\_controller.dart](/lib/modules/home/income/create/create_income_controller.dart) | Dart | 127 | 2 | 28 | 157 |
| [lib/modules/home/income/create/create\_income\_view.dart](/lib/modules/home/income/create/create_income_view.dart) | Dart | 361 | 17 | 9 | 387 |
| [lib/modules/home/income/create\_income\_binding.dart](/lib/modules/home/income/create_income_binding.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/modules/home/income/create\_income\_controller.dart](/lib/modules/home/income/create_income_controller.dart) | Dart | -143 | 0 | -20 | -163 |
| [lib/modules/home/income/create\_income\_view.dart](/lib/modules/home/income/create_income_view.dart) | Dart | -358 | 0 | -7 | -365 |
| [lib/modules/home/income/update/update\_income\_binding.dart](/lib/modules/home/income/update/update_income_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/income/update/update\_income\_controller.dart](/lib/modules/home/income/update/update_income_controller.dart) | Dart | 140 | 6 | 27 | 173 |
| [lib/modules/home/income/update/update\_income\_view.dart](/lib/modules/home/income/update/update_income_view.dart) | Dart | 371 | 0 | 8 | 379 |
| [lib/modules/home/refueling/create/create\_refueling\_binding.dart](/lib/modules/home/refueling/create/create_refueling_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/refueling/create/create\_refueling\_controller.dart](/lib/modules/home/refueling/create/create_refueling_controller.dart) | Dart | 261 | 9 | 43 | 313 |
| [lib/modules/home/refueling/create/create\_refueling\_view.dart](/lib/modules/home/refueling/create/create_refueling_view.dart) | Dart | 585 | 115 | 9 | 709 |
| [lib/modules/home/refueling/create\_refueling\_binding.dart](/lib/modules/home/refueling/create_refueling_binding.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/modules/home/refueling/create\_refueling\_controller.dart](/lib/modules/home/refueling/create_refueling_controller.dart) | Dart | -214 | -8 | -31 | -253 |
| [lib/modules/home/refueling/create\_refueling\_view.dart](/lib/modules/home/refueling/create_refueling_view.dart) | Dart | -593 | -13 | -9 | -615 |
| [lib/modules/home/refueling/update/update\_refueling\_binding.dart](/lib/modules/home/refueling/update/update_refueling_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/refueling/update/update\_refueling\_controller.dart](/lib/modules/home/refueling/update/update_refueling_controller.dart) | Dart | 263 | 1 | 41 | 305 |
| [lib/modules/home/refueling/update/update\_refueling\_view.dart](/lib/modules/home/refueling/update/update_refueling_view.dart) | Dart | 561 | 0 | 8 | 569 |
| [lib/modules/home/route/create/create\_route\_binding.dart](/lib/modules/home/route/create/create_route_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/route/create/create\_route\_controller.dart](/lib/modules/home/route/create/create_route_controller.dart) | Dart | 178 | 2 | 32 | 212 |
| [lib/modules/home/route/create/create\_route\_view.dart](/lib/modules/home/route/create/create_route_view.dart) | Dart | 528 | 39 | 8 | 575 |
| [lib/modules/home/route/create\_route\_binding.dart](/lib/modules/home/route/create_route_binding.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/modules/home/route/create\_route\_controller.dart](/lib/modules/home/route/create_route_controller.dart) | Dart | -163 | 0 | -22 | -185 |
| [lib/modules/home/route/create\_route\_view.dart](/lib/modules/home/route/create_route_view.dart) | Dart | -507 | 0 | -8 | -515 |
| [lib/modules/home/route/update/update\_route\_binding.dart](/lib/modules/home/route/update/update_route_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/route/update/update\_route\_controller.dart](/lib/modules/home/route/update/update_route_controller.dart) | Dart | 193 | 1 | 31 | 225 |
| [lib/modules/home/route/update/update\_route\_view.dart](/lib/modules/home/route/update/update_route_view.dart) | Dart | 527 | 0 | 8 | 535 |
| [lib/modules/home/service/create/create\_service\_binding.dart](/lib/modules/home/service/create/create_service_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/service/create/create\_service\_controller.dart](/lib/modules/home/service/create/create_service_controller.dart) | Dart | 153 | 2 | 31 | 186 |
| [lib/modules/home/service/create/create\_service\_view.dart](/lib/modules/home/service/create/create_service_view.dart) | Dart | 539 | 27 | 9 | 575 |
| [lib/modules/home/service/create\_service\_binding.dart](/lib/modules/home/service/create_service_binding.dart) | Dart | -8 | 0 | -2 | -10 |
| [lib/modules/home/service/create\_service\_controller.dart](/lib/modules/home/service/create_service_controller.dart) | Dart | -173 | 0 | -25 | -198 |
| [lib/modules/home/service/create\_service\_view.dart](/lib/modules/home/service/create_service_view.dart) | Dart | -532 | 0 | -8 | -540 |
| [lib/modules/home/service/type/service\_type\_controller.dart](/lib/modules/home/service/type/service_type_controller.dart) | Dart | 7 | 0 | -1 | 6 |
| [lib/modules/home/service/type/service\_type\_view.dart](/lib/modules/home/service/type/service_type_view.dart) | Dart | 9 | 0 | 0 | 9 |
| [lib/modules/home/service/update/update\_service\_binding.dart](/lib/modules/home/service/update/update_service_binding.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/home/service/update/update\_service\_controller.dart](/lib/modules/home/service/update/update_service_controller.dart) | Dart | 171 | 3 | 29 | 203 |
| [lib/modules/home/service/update/update\_service\_view.dart](/lib/modules/home/service/update/update_service_view.dart) | Dart | 557 | 0 | 8 | 565 |
| [lib/modules/more/general/create/create\_general\_controller.dart](/lib/modules/more/general/create/create_general_controller.dart) | Dart | -6 | 1 | 0 | -5 |
| [lib/modules/more/general/general\_view.dart](/lib/modules/more/general/general_view.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/modules/more/more\_view.dart](/lib/modules/more/more_view.dart) | Dart | -13 | 0 | 0 | -13 |
| [lib/modules/more/plan/plan\_bindings.dart](/lib/modules/more/plan/plan_bindings.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/more/plan/plan\_controller.dart](/lib/modules/more/plan/plan_controller.dart) | Dart | 16 | 0 | 6 | 22 |
| [lib/modules/more/plan/plan\_view.dart](/lib/modules/more/plan/plan_view.dart) | Dart | 355 | 0 | 6 | 361 |
| [lib/modules/more/vehicles/create/create\_vehicles\_controller.dart](/lib/modules/more/vehicles/create/create_vehicles_controller.dart) | Dart | 34 | 0 | 9 | 43 |
| [lib/modules/more/vehicles/create/create\_vehicles\_view.dart](/lib/modules/more/vehicles/create/create_vehicles_view.dart) | Dart | 54 | 0 | 1 | 55 |
| [lib/modules/more/vehicles/update/update\_vehicles\_bindings.dart](/lib/modules/more/vehicles/update/update_vehicles_bindings.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/modules/more/vehicles/update/update\_vehicles\_controller.dart](/lib/modules/more/vehicles/update/update_vehicles_controller.dart) | Dart | 130 | 0 | 29 | 159 |
| [lib/modules/more/vehicles/update/update\_vehicles\_view.dart](/lib/modules/more/vehicles/update/update_vehicles_view.dart) | Dart | 647 | 6 | 11 | 664 |
| [lib/modules/more/vehicles/vehicles\_controller.dart](/lib/modules/more/vehicles/vehicles_controller.dart) | Dart | 7 | 0 | 2 | 9 |
| [lib/modules/more/vehicles/vehicles\_view.dart](/lib/modules/more/vehicles/vehicles_view.dart) | Dart | 82 | 0 | 0 | 82 |
| [lib/modules/reminder/create/create\_reminder\_view.dart](/lib/modules/reminder/create/create_reminder_view.dart) | Dart | -15 | 0 | -2 | -17 |
| [lib/modules/reports/reports\_controller.dart](/lib/modules/reports/reports_controller.dart) | Dart | 493 | 76 | 74 | 643 |
| [lib/modules/reports/reports\_view.dart](/lib/modules/reports/reports_view.dart) | Dart | 457 | 5 | 8 | 470 |
| [lib/modules/setting/setting\_view.dart](/lib/modules/setting/setting_view.dart) | Dart | 0 | 2 | 0 | 2 |
| [lib/modules/splash\_screen.dart](/lib/modules/splash_screen.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/routes/app\_pages.dart](/lib/routes/app_pages.dart) | Dart | 49 | 0 | 2 | 51 |
| [lib/routes/app\_routes.dart](/lib/routes/app_routes.dart) | Dart | 7 | 7 | 0 | 14 |
| [lib/services/app\_service.dart](/lib/services/app_service.dart) | Dart | 51 | 0 | 9 | 60 |
| [lib/utils/constants.dart](/lib/utils/constants.dart) | Dart | 7 | 7 | 0 | 14 |
| [lib/utils/utils.dart](/lib/utils/utils.dart) | Dart | 122 | 13 | 13 | 148 |
| [pubspec.yaml](/pubspec.yaml) | YAML | 3 | 1 | 2 | 6 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details
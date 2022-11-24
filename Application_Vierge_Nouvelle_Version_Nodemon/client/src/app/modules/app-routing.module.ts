import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { AppComponent } from "../app.component";
import { PlanRepasComponent } from "../pages/plan-repas/plan-repas.component";
import { PlanRepasAdminComponent } from "../pages/plan-repas-admin/plan-repas-admin.component";

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "planrepas", component: PlanRepasComponent },
  { path: "admin", component: PlanRepasAdminComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }

import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { AppComponent } from "../app.component";
import { PlanRepasComponent } from "../pages/plan-repas/plan-repas.component";

const routes: Routes = [
  { path: "home", component: AppComponent },
  { path: "home/planrepas", component: PlanRepasComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }

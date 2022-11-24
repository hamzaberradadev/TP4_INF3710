import { CommonModule } from "@angular/common";
import { HttpClientModule } from "@angular/common/http";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from "@angular/platform-browser";
import { AppRoutingModule } from "./modules/app-routing.module";
import { AppComponent } from "./app.component";
import { CommunicationService } from "./services/communication.service";
import { AppMaterialModule } from './modules/material.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { PlanRepasComponent } from './pages/plan-repas/plan-repas.component';
import { PlanRepasAdminComponent } from './pages/plan-repas-admin/plan-repas-admin.component';
import { AddPlanRepasComponent } from './pages/add-plan-repas/add-plan-repas.component';
import { DeletePlanRepasComponent } from './pages/delete-plan-repas/delete-plan-repas.component';

@NgModule({
  declarations: [
    AppComponent,
    PlanRepasComponent,
    PlanRepasAdminComponent,
    AddPlanRepasComponent,
    DeletePlanRepasComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    HttpClientModule,
    FormsModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    ReactiveFormsModule,
    AppMaterialModule
  ],
  providers: [CommunicationService],
  entryComponents: [],
  bootstrap: [AppComponent],
})
export class AppModule { }

package com.sulake.habbo.avatar.generic
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_2;
   
   public class BodyView extends CategoryBaseView implements ICategoryBaseModel_2
   {
      private const TAB_BOY_ID:String = "tab_boy";
      
      private const TAB_GIRL_ID:String = "tab_girl";
      
      public function BodyView(param1:ICategoryBaseModel_1)
      {
         super(param1);
         UnknownVarFromCategoryBaseView_String_1 = "hd";
      }
      
      override public function reset() : void
      {
         super.reset();
         UnknownVarFromCategoryBaseView_String_1 = "hd";
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.getCategoryContainer("generic") as IWindowController_1;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         updateGridView("hd");
         UnknownVarFromCategoryBaseView_Boolean_1 = true;
         updateGenderTab();
      }
      
      override public function getWindowContainer() : IWindowController_1
      {
         if(!UnknownVarFromCategoryBaseView_Boolean_1)
         {
            init();
         }
         updateGenderTab();
         return _window;
      }
      
      public function updateGenderTab() : void
      {
         if(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1 == null)
         {
            return;
         }
         switch(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.gender)
         {
            case "M":
               activateTab("tab_boy");
               inactivateTab("tab_girl");
               break;
            case "F":
               activateTab("tab_girl");
               inactivateTab("tab_boy");
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         updateGenderTab();
         updateGridView(param1 == "" ? UnknownVarFromCategoryBaseView_String_1 : param1);
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_boy":
                  UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.gender = "M";
                  param1.stopPropagation();
                  break;
               case "tab_girl":
                  UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.gender = "F";
                  param1.stopPropagation();
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_boy":
               case "tab_girl":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_boy":
               case "tab_girl":
                  updateGenderTab();
            }
         }
      }
   }
}


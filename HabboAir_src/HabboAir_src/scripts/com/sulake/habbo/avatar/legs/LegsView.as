package com.sulake.habbo.avatar.legs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_2;
   
   public class LegsView extends CategoryBaseView implements ICategoryBaseModel_2
   {
      public function LegsView(param1:ICategoryBaseModel_1)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.getCategoryContainer("legs") as IWindowController_1;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         UnknownVarFromCategoryBaseView_Boolean_1 = true;
         if(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1 && UnknownVarFromCategoryBaseView_String_1 == "")
         {
            UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.switchCategory("lg");
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         param1 = param1 == "" ? UnknownVarFromCategoryBaseView_String_1 : param1;
         inactivateTab(_currentTabName);
         switch(param1)
         {
            case "lg":
               _currentTabName = "tab_pants";
               break;
            case "sh":
               _currentTabName = "tab_shoes";
               break;
            case "wa":
               _currentTabName = "tab_belts";
               break;
            default:
               throw new Error("[LegsView] Unknown item category: \"" + param1 + "\"");
         }
         UnknownVarFromCategoryBaseView_String_1 = param1;
         activateTab(_currentTabName);
         if(!UnknownVarFromCategoryBaseView_Boolean_1)
         {
            init();
         }
         updateGridView(UnknownVarFromCategoryBaseView_String_1);
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_pants":
                  switchCategory("lg");
                  break;
               case "tab_shoes":
                  switchCategory("sh");
                  break;
               case "tab_belts":
                  switchCategory("wa");
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_pants":
               case "tab_shoes":
               case "tab_belts":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_pants":
               case "tab_shoes":
               case "tab_belts":
                  if(_currentTabName != param2.name)
                  {
                     inactivateTab(param2.name);
                  }
            }
         }
      }
   }
}


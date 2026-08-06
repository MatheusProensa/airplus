package com.sulake.habbo.avatar.misc
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_2;
   
   public class MiscView extends CategoryBaseView implements ICategoryBaseModel_2
   {
      private const defaultCategory:String = "pt";
      
      public function MiscView(param1:ICategoryBaseModel_1)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.getCategoryContainer("misc") as IWindowController_1;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         UnknownVarFromCategoryBaseView_Boolean_1 = true;
         if(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1 && UnknownVarFromCategoryBaseView_String_1 == "")
         {
            UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.switchCategory("pt");
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
         inactivateTab(_currentTabName);
         param1 = param1 == "" ? UnknownVarFromCategoryBaseView_String_1 : param1;
         switch(param1)
         {
            case "pt":
               _currentTabName = "tab_pets";
               break;
            case "mc":
               _currentTabName = "tab_misc";
               break;
            default:
               throw new Error("[MiscView] Unknown item category: \"" + param1 + "\"");
         }
         UnknownVarFromCategoryBaseView_String_1 = param1;
         activateTab(_currentTabName);
         if(!UnknownVarFromCategoryBaseView_Boolean_1)
         {
            init();
         }
         updateGridView(param1);
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_pets":
                  switchCategory("pt");
                  break;
               case "tab_misc":
                  switchCategory("mc");
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_pets":
               case "tab_misc":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_pets":
               case "tab_misc":
                  if(_currentTabName != param2.name)
                  {
                     inactivateTab(param2.name);
                  }
            }
         }
      }
   }
}


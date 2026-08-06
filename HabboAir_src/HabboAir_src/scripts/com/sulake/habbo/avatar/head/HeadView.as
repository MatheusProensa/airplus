package com.sulake.habbo.avatar.head
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_2;
   
   public class HeadView extends CategoryBaseView implements ICategoryBaseModel_2
   {
      public function HeadView(param1:ICategoryBaseModel_1)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.getCategoryContainer("head") as IWindowController_1;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         UnknownVarFromCategoryBaseView_Boolean_1 = true;
         if(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1 && UnknownVarFromCategoryBaseView_String_1 == "")
         {
            UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.switchCategory("hr");
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
            case "hr":
               _currentTabName = "tab_hair";
               break;
            case "ha":
               _currentTabName = "tab_hat";
               break;
            case "he":
               _currentTabName = "tab_accessories";
               break;
            case "ea":
               _currentTabName = "tab_eyewear";
               break;
            case "fa":
               _currentTabName = "tab_masks";
               break;
            default:
               throw new Error("[HeadView] Unknown item category: \"" + param1 + "\"");
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
               case "tab_hair":
                  switchCategory("hr");
                  break;
               case "tab_hat":
                  switchCategory("ha");
                  break;
               case "tab_accessories":
                  switchCategory("he");
                  break;
               case "tab_eyewear":
                  switchCategory("ea");
                  break;
               case "tab_masks":
                  switchCategory("fa");
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_hair":
               case "tab_hat":
               case "tab_accessories":
               case "tab_eyewear":
               case "tab_masks":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_hair":
               case "tab_hat":
               case "tab_accessories":
               case "tab_eyewear":
               case "tab_masks":
                  if(_currentTabName != param2.name)
                  {
                     inactivateTab(param2.name);
                  }
            }
         }
      }
   }
}


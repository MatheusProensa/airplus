package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   
   public class MonsterPlantSeedContextMenuView extends FurnitureContextInfoView
   {
      private var UnknownVarFromMonsterPlantSeedContextMenuView_Int_1:int;
      
      public function MonsterPlantSeedContextMenuView(param1:UnknownIHabboUiWidgetContextmenu1)
      {
         super(param1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc2_:IWindowModel = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         if(UnknownVarFromContextInfoView_Boolean_1)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("monsterplant_seed_menu")).content as XML;
               _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _loc2_ = _window.findChildByName("minimize");
               if(_loc2_ != null)
               {
                  _loc2_.addEventListener("WME_CLICK",onMinimize);
                  _loc2_.addEventListener("WME_OVER",onMinimizeHover);
                  _loc2_.addEventListener("WME_OUT",onMinimizeHover);
               }
            }
            _window.findChildByName("furni_name").caption = "${furni.mnstr_seed.name}";
            _window.findChildByName("buttons").procedure = buttonEventProc;
            _window.visible = false;
            activeView = _window;
            UnknownVarFromContextInfoView_Boolean_2 = false;
         }
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:FurnitureContextMenuWidget = null;
         if(disposed || !_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc5_:* = param2.parent.name;
               if("use" === _loc5_)
               {
                  _loc4_ = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as FurnitureContextMenuWidget;
                  if(_loc4_ != null)
                  {
                     _loc4_.showPlantSeedConfirmationDialog(_roomObject);
                  }
               }
            }
            _loc3_ = true;
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
         }
      }
      
      public function set objectCategory(param1:int) : void
      {
         UnknownVarFromMonsterPlantSeedContextMenuView_Int_1 = param1;
      }
   }
}


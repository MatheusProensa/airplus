package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   
   public class BreedPetView extends AvatarContextInfoButtonView
   {
      private static const MODE_NORMAL:int = 0;
      
      private var _mode:int;
      
      private var UnknownVarFromBreedPetView_UseProductItem_1:UseProductItem;
      
      private var UnknownVarFromBreedPetView_Boolean_1:Boolean;
      
      public function BreedPetView(param1:AvatarInfoWidget)
      {
         super(param1);
         UnknownVarFromContextInfoView_Boolean_5 = false;
      }
      
      public static function setup(param1:BreedPetView, param2:int, param3:String, param4:int, param5:int, param6:UseProductItem, param7:Boolean) : void
      {
         param1.UnknownVarFromBreedPetView_UseProductItem_1 = param6;
         param1.UnknownVarFromBreedPetView_Boolean_1 = param7;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      public function get objectId() : int
      {
         return UnknownVarFromBreedPetView_UseProductItem_1.id;
      }
      
      public function get requestRoomObjectId() : int
      {
         return UnknownVarFromBreedPetView_UseProductItem_1.requestRoomObjectId;
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         if(UnknownVarFromBreedPetView_UseProductItem_1)
         {
            UnknownVarFromBreedPetView_UseProductItem_1.dispose();
         }
         UnknownVarFromBreedPetView_UseProductItem_1 = null;
         super.dispose();
      }
      
      private function resolveMode() : void
      {
         var _loc1_:int = widget.handler.roomSession.roomId;
         _mode = 0;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         resolveMode();
         if(UnknownVarFromContextInfoView_Boolean_1)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("breed_pet_menu")).content as XML;
               _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            UnknownVarFromButtonMenuView_IItemListWindow_1 = _window.findChildByName("buttons") as IItemListWindow;
            UnknownVarFromButtonMenuView_IItemListWindow_1.procedure = buttonEventProc;
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      public function updateButtons() : void
      {
         var _loc2_:int = 0;
         if(!_window || !UnknownVarFromButtonMenuView_IItemListWindow_1)
         {
            return;
         }
         UnknownVarFromButtonMenuView_IItemListWindow_1.autoArrangeItems = false;
         var _loc1_:int = UnknownVarFromButtonMenuView_IItemListWindow_1.numListItems;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            UnknownVarFromButtonMenuView_IItemListWindow_1.getListItemAt(_loc2_).visible = false;
            _loc2_++;
         }
         switch(_mode)
         {
            case 0:
               if(UnknownVarFromBreedPetView_Boolean_1)
               {
                  showButton("breed");
                  break;
               }
         }
         UnknownVarFromButtonMenuView_IItemListWindow_1.autoArrangeItems = true;
         UnknownVarFromButtonMenuView_IItemListWindow_1.visible = true;
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:* = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               var _loc5_:* = param2.parent.name;
               if("breed" === _loc5_)
               {
                  widget.showBreedMonsterPlantsConfirmationView(UnknownVarFromBreedPetView_UseProductItem_1.requestRoomObjectId,UnknownVarFromBreedPetView_UseProductItem_1.targetRoomObjectId,false);
               }
            }
            if(_loc4_)
            {
               UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.messageListener.processWidgetMessage(_loc4_);
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            widget.removeBreedPetViews();
         }
      }
      
      private function changeMode(param1:int) : void
      {
         _mode = param1;
         updateButtons();
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as AvatarInfoWidget;
      }
   }
}


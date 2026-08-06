package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class DecorateModeView extends AvatarContextInfoButtonView
   {
      public function DecorateModeView(param1:AvatarInfoWidget, param2:int, param3:String, param4:int)
      {
         super(param1);
         UnknownVarFromContextInfoView_Boolean_5 = false;
         AvatarContextInfoButtonView.setup(this,param2,param3,param4,1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("own_avatar_decorating")).content as XML;
            _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
            if(!_window)
            {
               return;
            }
            _window.addEventListener("WME_OVER",onMouseHoverEvent);
            _window.addEventListener("WME_OUT",onMouseHoverEvent);
            UnknownVarFromButtonMenuView_IItemListWindow_1 = _window.findChildByName("buttons") as IItemListWindow;
            UnknownVarFromButtonMenuView_IItemListWindow_1.procedure = eventProc;
            updateButtons();
         }
         activeView = _window;
      }
      
      override public function show() : void
      {
         if(UnknownVarFromContextInfoView_IWindowController_1_2 != null)
         {
            UnknownVarFromContextInfoView_IWindowController_1_2.visible = true;
            UnknownVarFromContextInfoView_IWindowController_1_2.activate();
         }
      }
      
      override public function hide(param1:Boolean) : void
      {
         if(UnknownVarFromContextInfoView_IWindowController_1_2 != null)
         {
            UnknownVarFromContextInfoView_IWindowController_1_2.visible = false;
         }
         UnknownVarFromContextInfoView_Boolean_2 = false;
      }
      
      override protected function set activeView(param1:IWindowController_1) : void
      {
         if(!param1)
         {
            return;
         }
         UnknownVarFromContextInfoView_IWindowController_1_2 = param1;
      }
      
      public function isVisible() : Boolean
      {
         return UnknownVarFromContextInfoView_IWindowController_1_2 && UnknownVarFromContextInfoView_IWindowController_1_2.visible;
      }
      
      public function updateButtons() : void
      {
         showButton("decorate");
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc3_:* = param2.parent.name;
               if("decorate" === _loc3_)
               {
                  widget.isUserDecorating = false;
               }
            }
         }
         else if(param1.type == "WME_OVER")
         {
            super.buttonEventProc(param1,param2);
            UnknownVarFromContextInfoView_Boolean_2 = true;
         }
         else if(param1.type == "WME_OUT")
         {
            super.buttonEventProc(param1,param2);
            UnknownVarFromContextInfoView_Boolean_2 = false;
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
      }
      
      override public function get maximumBlend() : Number
      {
         return 0.8;
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as AvatarInfoWidget;
      }
   }
}


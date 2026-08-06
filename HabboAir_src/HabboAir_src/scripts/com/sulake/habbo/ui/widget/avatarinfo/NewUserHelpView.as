package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   
   public class NewUserHelpView extends AvatarContextInfoButtonView
   {
      private var _caption:String = "";
      
      public function NewUserHelpView(param1:AvatarInfoWidget)
      {
         super(param1);
         _caption = param1.localization.getLocalization("room.enter.infostand.caption","");
         UnknownVarFromContextInfoView_Int_2 = param1.configuration.getInteger("room.enter.infostand.fade.start.delay",5000);
      }
      
      public static function setup(param1:AvatarContextInfoButtonView, param2:int, param3:String, param4:int, param5:int) : void
      {
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc2_:IWindowModel = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("new_user_help").content as XML;
            _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
            if(!_window)
            {
               return;
            }
            _loc2_ = _window.findChildByName("help");
            _loc2_.caption = _caption;
            _window.invalidate();
         }
         activeView = _window;
      }
      
      public function get widget() : AvatarInfoWidget
      {
         return UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as AvatarInfoWidget;
      }
   }
}


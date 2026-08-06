package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class InternalLinkButtonElementHandler extends AbstractButtonElementHandler
   {
      private var UnknownVarFromInternalLinkButtonElementHandler_String_1:String;
      
      private var _configurationCode:String;
      
      public function InternalLinkButtonElementHandler()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         UnknownVarFromInternalLinkButtonElementHandler_String_1 = param3[2];
         _configurationCode = param4.configurationCode;
      }
      
      override protected function onClick() : void
      {
         landingView.context.createLinkEvent(UnknownVarFromInternalLinkButtonElementHandler_String_1);
         landingView.tracking.trackEventLog("LandingView",_configurationCode,"client_link",UnknownVarFromInternalLinkButtonElementHandler_String_1);
      }
   }
}


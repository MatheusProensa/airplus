package com.sulake.habbo.ui.widget.friendrequest
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FriendRequestDialog
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromFriendRequestDialog_FriendRequestWidget_1:FriendRequestWidget;
      
      private var UnknownVarFromFriendRequestDialog_Int_1:int;
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var UnknownVarFromFriendRequestDialog_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFriendRequestDialog_Boolean_2:Boolean = false;
      
      private var UnknownVarFromFriendRequestDialog_Boolean_3:Boolean = false;
      
      public function FriendRequestDialog(param1:FriendRequestWidget, param2:int, param3:int, param4:String)
      {
         super();
         UnknownVarFromFriendRequestDialog_FriendRequestWidget_1 = param1;
         UnknownVarFromFriendRequestDialog_Int_1 = param2;
         _userId = param3;
         _userName = param4;
      }
      
      public function dispose() : void
      {
         UnknownVarFromFriendRequestDialog_FriendRequestWidget_1 = null;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
      }
      
      private function addMouseClickListener(param1:IWindowModel, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(1,true);
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      private function createWindow() : void
      {
         if(!UnknownVarFromFriendRequestDialog_FriendRequestWidget_1 || !UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.assets || !UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.windowManager)
         {
            return;
         }
         var _loc3_:XmlAsset = UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.assets.getAssetByName("instant_friend_request") as XmlAsset;
         if(!_loc3_)
         {
            return;
         }
         _window = UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.windowManager.buildFromXML(_loc3_.content as XML,0) as IWindowController_1;
         if(!_window)
         {
            return;
         }
         _window.addEventListener("WE_DEACTIVATED",onDeactivated);
         var _loc6_:IRegionWindow = _window.findChildByName("profile_region") as IRegionWindow;
         if(_loc6_)
         {
            _loc6_.procedure = onProfile;
            _loc6_.toolTipCaption = UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.localizations.getLocalization("infostand.profile.link.tooltip","");
            _loc6_.toolTipDelay = 100;
         }
         var _loc4_:ITextWindow = _window.findChildByName("text") as ITextWindow;
         if(_loc4_)
         {
            _loc4_.text = UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.localizations.registerParameter("widget.friendrequest.from","username",_userName);
         }
         var _loc7_:IWindowModel = _window.findChildByName("accept_button");
         addMouseClickListener(_loc7_,onAccept);
         var _loc5_:IWindowModel = _window.findChildByName("decline_button");
         addMouseClickListener(_loc5_,onDecline);
         var _loc2_:IWindowModel = _window.findChildByName("close_button");
         addMouseClickListener(_loc2_,onClose);
         var _loc1_:IIconWindow = _window.findChildByName("profile_icon") as IIconWindow;
         _loc1_.procedure = onProfileIcon;
         _window.procedure = windowEventHandler;
         _window.visible = false;
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!param1)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_OVER":
               UnknownVarFromFriendRequestDialog_Boolean_1 = true;
               break;
            case "WME_OUT":
               UnknownVarFromFriendRequestDialog_Boolean_1 = false;
               break;
            case "WME_DOWN":
               UnknownVarFromFriendRequestDialog_Boolean_2 = true;
               break;
            case "WME_UP":
            case "WME_UP_OUTSIDE":
               UnknownVarFromFriendRequestDialog_Boolean_2 = false;
         }
      }
      
      public function setImageAsset(param1:IBitmapWrapperController, param2:String) : void
      {
         if(!param1 || !UnknownVarFromFriendRequestDialog_FriendRequestWidget_1 || !UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.assets)
         {
            return;
         }
         var _loc4_:BitmapDataAsset = UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.assets.getAssetByName(param2) as BitmapDataAsset;
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:BitmapData = _loc4_.content as BitmapData;
         if(!_loc3_)
         {
            return;
         }
         if(param1.bitmap)
         {
            param1.bitmap.dispose();
         }
         param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         param1.bitmap.draw(_loc3_);
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function show() : void
      {
         if(_window != null)
         {
            _window.visible = true;
            _window.activate();
         }
      }
      
      public function set targetRect(param1:Rectangle) : void
      {
         var _loc4_:Point = null;
         if(!param1)
         {
            UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.ignoreRequest(UnknownVarFromFriendRequestDialog_Int_1);
            return;
         }
         if(UnknownVarFromFriendRequestDialog_Boolean_1 || UnknownVarFromFriendRequestDialog_Boolean_2)
         {
            return;
         }
         var _loc2_:Boolean = true;
         if(!_window)
         {
            createWindow();
            _loc2_ = false;
         }
         if(!_window)
         {
            return;
         }
         var _loc5_:Point = new Point(param1.left + param1.width / 2 - _window.width / 2,param1.top - _window.height + 10);
         var _loc3_:Number = Point.distance(_window.position,_loc5_);
         if(_loc2_ && _loc3_ > 5)
         {
            _loc4_ = Point.interpolate(_window.position,_loc5_,0.5);
            _window.x = _loc4_.x;
            _window.y = _loc4_.y;
         }
         else
         {
            _window.x = _loc5_.x;
            _window.y = _loc5_.y;
         }
         if(!_window.visible)
         {
            show();
         }
         if(UnknownVarFromFriendRequestDialog_Boolean_3)
         {
            show();
            UnknownVarFromFriendRequestDialog_Boolean_3 = false;
         }
      }
      
      private function onDeactivated(param1:WindowEvent) : void
      {
         UnknownVarFromFriendRequestDialog_Boolean_3 = true;
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromFriendRequestDialog_FriendRequestWidget_1 != null)
         {
            UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.ignoreRequest(UnknownVarFromFriendRequestDialog_Int_1);
         }
      }
      
      private function onAccept(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromFriendRequestDialog_FriendRequestWidget_1 != null)
         {
            UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.acceptRequest(UnknownVarFromFriendRequestDialog_Int_1);
         }
      }
      
      private function onDecline(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromFriendRequestDialog_FriendRequestWidget_1 != null)
         {
            UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.declineRequest(UnknownVarFromFriendRequestDialog_Int_1);
         }
      }
      
      private function onProfile(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:ITextWindow = null;
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.showProfile(_userId,"instantFriendRequest_name");
         }
         if(param1.type == "WME_OVER")
         {
            _loc3_ = _window.findChildByName("text") as ITextWindow;
            _loc3_.underline = true;
         }
         if(param1.type == "WME_OUT")
         {
            _loc3_ = _window.findChildByName("text") as ITextWindow;
            _loc3_.underline = false;
         }
      }
      
      private function onProfileIcon(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IIconWindow = null;
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromFriendRequestDialog_FriendRequestWidget_1.showProfile(_userId,"instantFriendRequest_icon");
         }
         if(param1.type == "WME_OVER")
         {
            _loc3_ = _window.findChildByName("profile_icon") as IIconWindow;
            _loc3_.style = 22;
            _loc3_.invalidate();
         }
         if(param1.type == "WME_OUT")
         {
            _loc3_ = _window.findChildByName("profile_icon") as IIconWindow;
            _loc3_.style = 21;
            _loc3_.invalidate();
         }
      }
   }
}


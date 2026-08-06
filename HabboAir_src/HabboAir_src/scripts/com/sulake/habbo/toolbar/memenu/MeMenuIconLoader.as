package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MeMenuIconLoader implements UnknownIHabboAvatar1
   {
      private static const MAX_ICON_HEIGHT:int = 50;
      
      private static const HEAD_MARGIN:int = 3;
      
      private var _toolbar:HabboToolbar;
      
      private var UnknownVarFromMeMenuIconLoader_String_1:String;
      
      private var UnknownVarFromMeMenuIconLoader_BitmapData_1:BitmapData;
      
      private var UnknownVarFromMeMenuIconLoader_BitmapData_2:BitmapData;
      
      private var UnknownVarFromMeMenuIconLoader_UserObjectEvent_1:UserObjectEvent;
      
      private var UnknownVarFromMeMenuIconLoader_UserChangeMessageEvent_1:UserChangeMessageEvent;
      
      public function MeMenuIconLoader(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         UnknownVarFromMeMenuIconLoader_UserObjectEvent_1 = new UserObjectEvent(onUserObject);
         UnknownVarFromMeMenuIconLoader_UserChangeMessageEvent_1 = new UserChangeMessageEvent(onUserChange);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(UnknownVarFromMeMenuIconLoader_UserObjectEvent_1);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(UnknownVarFromMeMenuIconLoader_UserChangeMessageEvent_1);
         setMeMenuToolbarIcon();
      }
      
      private function setMeMenuToolbarIcon(param1:String = null) : void
      {
         var _loc3_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc8_:IAvatarImage_2 = null;
         var _loc6_:* = null;
         var _loc9_:BitmapData = null;
         var _loc2_:Rectangle = null;
         if(_toolbar.avatarRenderManager != null)
         {
            _loc7_ = param1 == null ? _toolbar.sessionDataManager.figure : param1;
            if(_loc7_ != UnknownVarFromMeMenuIconLoader_String_1)
            {
               _loc4_ = _toolbar.sessionDataManager.gender;
               _loc8_ = _toolbar.avatarRenderManager.createAvatarImage(_loc7_,"h",_loc4_,this);
               if(_loc8_ != null)
               {
                  _loc8_.setDirection("full",2);
                  _loc3_ = _loc8_.getCroppedImage("full");
                  _loc5_ = _loc8_.getCroppedImage("head");
                  _loc8_.dispose();
               }
               UnknownVarFromMeMenuIconLoader_String_1 = _loc7_;
               if(UnknownVarFromMeMenuIconLoader_BitmapData_1 != null)
               {
                  UnknownVarFromMeMenuIconLoader_BitmapData_1.dispose();
               }
               UnknownVarFromMeMenuIconLoader_BitmapData_1 = _loc3_;
               if(UnknownVarFromMeMenuIconLoader_BitmapData_2 != null)
               {
                  UnknownVarFromMeMenuIconLoader_BitmapData_2.dispose();
               }
               UnknownVarFromMeMenuIconLoader_BitmapData_2 = _loc5_;
            }
            else
            {
               _loc3_ = UnknownVarFromMeMenuIconLoader_BitmapData_1;
               _loc5_ = UnknownVarFromMeMenuIconLoader_BitmapData_2;
            }
         }
         if(_toolbar != null)
         {
            if(_loc3_ != null && _loc5_ != null)
            {
               if(_loc3_.height > 50)
               {
                  _loc9_ = new BitmapData(_loc3_.width,50,true,0);
                  _loc2_ = _loc9_.rect.clone();
                  if(_loc5_.height > 50 - 3)
                  {
                     _loc2_.offset(0,_loc5_.height - 50 + 3);
                  }
                  _loc9_.copyPixels(_loc3_,_loc2_,new Point(0,0));
                  _loc6_ = _loc9_;
               }
               else
               {
                  _loc6_ = _loc3_.clone();
               }
            }
            _toolbar.setIconBitmap("HTIE_ICON_MEMENU",_loc6_);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         UnknownVarFromMeMenuIconLoader_String_1 = "";
         setMeMenuToolbarIcon();
      }
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         setMeMenuToolbarIcon(param1.getParser().figure);
      }
      
      private function onUserChange(param1:UserChangeMessageEvent) : void
      {
         if(param1.id == -1)
         {
            setMeMenuToolbarIcon(param1.figure);
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromMeMenuIconLoader_UserObjectEvent_1 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromMeMenuIconLoader_UserObjectEvent_1);
            UnknownVarFromMeMenuIconLoader_UserObjectEvent_1 = null;
         }
         if(UnknownVarFromMeMenuIconLoader_UserChangeMessageEvent_1 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromMeMenuIconLoader_UserChangeMessageEvent_1);
            UnknownVarFromMeMenuIconLoader_UserChangeMessageEvent_1 = null;
         }
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
   }
}


package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IOutfit;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class WardrobeSlot implements IOutfit, UnknownIHabboAvatar1
   {
      private var UnknownVarFromWardrobeSlot_HabboAvatarEditor_1:HabboAvatarEditor;
      
      private var _figure:String;
      
      private var _gender:String;
      
      private var UnknownVarFromWardrobeSlot_Boolean_1:Boolean;
      
      private var _view:IWindowController_1;
      
      private var UnknownVarFromWardrobeSlot_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _id:int;
      
      private var _disposed:Boolean;
      
      public function WardrobeSlot(param1:IWindowModel, param2:HabboAvatarEditor, param3:int, param4:Boolean, param5:String = null, param6:String = null)
      {
         super();
         UnknownVarFromWardrobeSlot_HabboAvatarEditor_1 = param2;
         _id = param3;
         createView(param1);
         update(param5,param6,param4);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function update(param1:String, param2:String, param3:Boolean) : void
      {
         switch(param2)
         {
            case "M":
            case "m":
            case "M":
               param2 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param2 = "F";
         }
         _figure = param1;
         _gender = param2;
         UnknownVarFromWardrobeSlot_Boolean_1 = param3;
         updateView();
      }
      
      private function createView(param1:IWindowModel) : void
      {
         _view = param1.clone() as IWindowController_1;
         _view.procedure = eventHandler;
         _view.visible = false;
         UnknownVarFromWardrobeSlot_IBitmapWrapperController_1 = _view.findChildByName("image") as IBitmapWrapperController;
      }
      
      public function dispose() : void
      {
         UnknownVarFromWardrobeSlot_HabboAvatarEditor_1 = null;
         _figure = null;
         _gender = null;
         UnknownVarFromWardrobeSlot_IBitmapWrapperController_1 = null;
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function updateView() : void
      {
         var _loc1_:BitmapData = null;
         var _loc5_:IAvatarImage_2 = null;
         var _loc9_:BitmapDataAsset = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:Boolean = true;
         var _loc6_:Boolean = UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.manager.getBoolean("zoom.enabled");
         if(_figure && UnknownVarFromWardrobeSlot_Boolean_1)
         {
            _loc5_ = UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.manager.avatarRenderManager.createAvatarImage(figure,_loc6_ ? "h" : "sh",_gender,this);
            if(_loc5_)
            {
               _loc5_.setDirection("full",4);
               _loc1_ = _loc5_.getCroppedImage("full",_loc6_ ? 0.5 : 1);
               _loc5_.dispose();
            }
         }
         else
         {
            _loc9_ = UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.manager.windowManager.assets.getAssetByName("avatar_editor_wardrobe_empty_slot") as BitmapDataAsset;
            if(_loc9_)
            {
               _loc1_ = _loc9_.content as BitmapData;
               _loc8_ = false;
            }
         }
         if(!_loc1_)
         {
            return;
         }
         if(UnknownVarFromWardrobeSlot_IBitmapWrapperController_1)
         {
            if(UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.bitmap)
            {
               UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.bitmap.dispose();
            }
            UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.width,UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.height,true,0);
            _loc3_ = (UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.width - _loc1_.width) / 2;
            _loc4_ = (UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.height - _loc1_.height) / 2;
            UnknownVarFromWardrobeSlot_IBitmapWrapperController_1.bitmap.draw(_loc1_,new Matrix(1,0,0,1,_loc3_,_loc4_));
         }
         if(_loc8_)
         {
            _loc1_.dispose();
         }
         var _loc7_:UnknownICoreWindowComponents5 = _view.findChildByName("set_button") as UnknownICoreWindowComponents5;
         if(_loc7_)
         {
            _loc7_.visible = UnknownVarFromWardrobeSlot_Boolean_1;
         }
         var _loc2_:UnknownICoreWindowComponents5 = _view.findChildByName("get_button") as UnknownICoreWindowComponents5;
         if(_loc2_)
         {
            _loc2_.visible = UnknownVarFromWardrobeSlot_Boolean_1 && _figure != null;
         }
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.manager.windowManager.LilithCustomsInstance.OnWardrobeSlotEventHandler(this,param2,UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.instanceId) == false)
         {
            return;
         }
         if(!UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.verifyClubLevel())
         {
            return;
         }
         switch(param2.name)
         {
            case "set_button":
               _figure = UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.figureData.getFigureString();
               _gender = UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.gender;
               UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.handler.saveWardrobeOutfit(_id,this);
               updateView();
               break;
            case "get_button":
            case "get_figure":
               if(_figure)
               {
                  UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.setNftOutfit(null);
                  UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.loadAvatarInEditor(_figure,_gender,UnknownVarFromWardrobeSlot_HabboAvatarEditor_1.clubMemberLevel);
               }
         }
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get view() : IWindowController_1
      {
         return _view;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateView();
      }
   }
}


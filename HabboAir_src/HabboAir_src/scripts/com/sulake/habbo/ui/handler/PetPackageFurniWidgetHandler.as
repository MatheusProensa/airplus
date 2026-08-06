package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class PetPackageFurniWidgetHandler implements IRoomWidgetHandler, UnknownIHabboRoom1
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromPetPackageFurniWidgetHandler_Int_1:int = -1;
      
      public function PetPackageFurniWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_PET_PACKAGE_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWOPPM_OPEN_PET_PACKAGE"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetOpenPetPackageMessage = null;
         var _loc3_:* = param1.type;
         if("RWOPPM_OPEN_PET_PACKAGE" === _loc3_)
         {
            _loc2_ = param1 as RoomWidgetOpenPetPackageMessage;
            if(_container != null && _container.roomSession != null)
            {
               _container.roomSession.sendOpenPetPackageMessage(_loc2_.objectId,_loc2_.name);
            }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSOPPE_OPEN_PET_PACKAGE_REQUESTED","RSOPPE_OPEN_PET_PACKAGE_RESULT"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc5_:RoomSessionPetPackageEvent = null;
         var _loc3_:RoomWidgetPetPackageUpdateEvent = null;
         var _loc4_:BitmapData = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:String = null;
         if(param1 == null)
         {
            return;
         }
         if(_container != null && _container.events != null && param1 != null)
         {
            switch(param1.type)
            {
               case "RSOPPE_OPEN_PET_PACKAGE_REQUESTED":
                  _loc5_ = param1 as RoomSessionPetPackageEvent;
                  UnknownVarFromPetPackageFurniWidgetHandler_Int_1 = _loc5_.objectId;
                  _loc4_ = getPetImage(_loc5_.figureData);
                  _loc6_ = _loc5_.figureData?.typeId;
                  _loc3_ = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED",UnknownVarFromPetPackageFurniWidgetHandler_Int_1,_loc4_,-1,null,_loc6_);
                  _container.events.dispatchEvent(_loc3_);
                  break;
               case "RSOPPE_OPEN_PET_PACKAGE_RESULT":
                  _loc5_ = param1 as RoomSessionPetPackageEvent;
                  UnknownVarFromPetPackageFurniWidgetHandler_Int_1 = _loc5_.objectId;
                  _loc2_ = _loc5_.nameValidationStatus;
                  _loc7_ = _loc5_.nameValidationInfo;
                  _loc3_ = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_RESULT",UnknownVarFromPetPackageFurniWidgetHandler_Int_1,null,_loc2_,_loc7_,-1);
                  _container.events.dispatchEvent(_loc3_);
            }
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _container = null;
         UnknownVarFromPetPackageFurniWidgetHandler_Int_1 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE",UnknownVarFromPetPackageFurniWidgetHandler_Int_1,param2,-1,null,-1);
         _container.events.dispatchEvent(_loc3_);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function getPetImage(param1:PetFigureData) : BitmapData
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:UnknownHabboRoom1 = null;
         if(param1 != null)
         {
            _loc2_ = parseInt(param1.color,16);
            _loc3_ = 0;
            _loc4_ = _container.roomEngine.getPetImage(param1.typeId,param1.paletteId,_loc2_,new Vector3d(90),64,this,true,_loc3_);
            if(_loc4_ != null)
            {
               return _loc4_.data;
            }
         }
         return null;
      }
   }
}


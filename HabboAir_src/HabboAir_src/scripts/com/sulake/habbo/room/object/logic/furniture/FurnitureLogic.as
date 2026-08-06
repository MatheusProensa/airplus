package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectHeightUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;
   import com.sulake.habbo.room.object.logic.MovingObjectLogic;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.UnknownRoomUtils1;
   import com.sulake.room.utils.Vector3d;
   
   public class FurnitureLogic extends MovingObjectLogic
   {
      private static const BOUNCE_STEPS:int = 8;
      
      private static const BOUNCE_STEP_HEIGHT:Number = 0.0625;
      
      private var _mouseOver:Boolean = false;
      
      private var UnknownVarFromFurnitureLogic_Number_1:Number = 0;
      
      private var UnknownVarFromFurnitureLogic_Number_2:Number = 0;
      
      private var UnknownVarFromFurnitureLogic_Number_3:Number = 0;
      
      private var UnknownVarFromFurnitureLogic_Number_4:Number = 0;
      
      private var UnknownVarFromFurnitureLogic_Number_5:Number = 0;
      
      private var UnknownVarFromFurnitureLogic_Number_6:Number = 0;
      
      private var UnknownVarFromFurnitureLogic_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFurnitureLogic_Int_1:int = 0;
      
      private var _storedRotateMessage:RoomObjectUpdateMessage;
      
      private var UnknownVarFromFurnitureLogic_Vector3d_1:Vector3d = new Vector3d();
      
      private var _directions:Array = [];
      
      public function FurnitureLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["RORAE_ROOM_AD_TOOLTIP_SHOW","RORAE_ROOM_AD_TOOLTIP_HIDE","RORAE_ROOM_AD_FURNI_DOUBLE_CLICK","ROSCE_STATE_CHANGE","ROE_MOUSE_CLICK","RORAE_ROOM_AD_FURNI_CLICK","ROE_MOUSE_DOWN"];
         if(widget != null)
         {
            _loc1_.push("ROWRE_OPEN_WIDGET");
            _loc1_.push("ROWRE_CLOSE_WIDGET");
         }
         if(contextMenu != null)
         {
            _loc1_.push("ROWRE_OPEN_FURNI_CONTEXT_MENU");
            _loc1_.push("ROWRE_CLOSE_FURNI_CONTEXT_MENU");
         }
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _storedRotateMessage = null;
         _directions = null;
      }
      
      override public function set object(param1:IRoomObjectController) : void
      {
         super.object = param1;
         if(param1 != null && param1.getLocation().length > 0)
         {
            UnknownVarFromFurnitureLogic_Boolean_1 = true;
         }
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc6_:int = 0;
         var _loc11_:XML = null;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromFurnitureLogic_Number_1 = 0;
         UnknownVarFromFurnitureLogic_Number_2 = 0;
         UnknownVarFromFurnitureLogic_Number_3 = 0;
         _directions = [];
         var _loc10_:XMLList = param1.model.dimensions;
         if(_loc10_.length() == 0)
         {
            return;
         }
         var _loc2_:XMLList = _loc10_.@x;
         if(_loc2_.length() == 1)
         {
            UnknownVarFromFurnitureLogic_Number_1 = Number(_loc2_);
         }
         _loc2_ = _loc10_.@y;
         if(_loc2_.length() == 1)
         {
            UnknownVarFromFurnitureLogic_Number_2 = Number(_loc2_);
         }
         _loc2_ = _loc10_.@z;
         if(_loc2_.length() == 1)
         {
            UnknownVarFromFurnitureLogic_Number_3 = Number(_loc2_);
         }
         UnknownVarFromFurnitureLogic_Number_4 = UnknownVarFromFurnitureLogic_Number_1 / 2;
         UnknownVarFromFurnitureLogic_Number_5 = UnknownVarFromFurnitureLogic_Number_2 / 2;
         _loc2_ = _loc10_.@centerZ;
         if(_loc2_.length() == 1)
         {
            UnknownVarFromFurnitureLogic_Number_6 = Number(_loc2_);
         }
         else
         {
            UnknownVarFromFurnitureLogic_Number_6 = UnknownVarFromFurnitureLogic_Number_3 / 2;
         }
         var _loc4_:XMLList = param1.model.directions.direction;
         var _loc5_:Array = ["id"];
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc11_ = _loc4_[_loc6_];
            if(UnknownRoomUtils1.checkRequiredAttributes(_loc11_,_loc5_))
            {
               _loc7_ = parseInt(_loc11_.@id);
               _directions.push(_loc7_);
            }
            _loc6_++;
         }
         _directions.sort(16);
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         var _loc9_:XMLList = param1.customvars.variable;
         var _loc8_:Array = [];
         for each(var _loc3_ in _loc9_)
         {
            _loc8_.push(_loc3_.@name.toString());
         }
         object.getModelController().setStringArray("furniture_custom_variables",_loc8_,true);
         object.getModelController().setNumber("furniture_size_x",UnknownVarFromFurnitureLogic_Number_1,true);
         object.getModelController().setNumber("furniture_size_y",UnknownVarFromFurnitureLogic_Number_2,true);
         if(!object.getModelController().hasNumber("furniture_size_z"))
         {
            object.getModelController().setNumber("furniture_size_z",UnknownVarFromFurnitureLogic_Number_3);
         }
         object.getModelController().setNumber("furniture_center_x",UnknownVarFromFurnitureLogic_Number_4,true);
         object.getModelController().setNumber("furniture_center_y",UnknownVarFromFurnitureLogic_Number_5,true);
         object.getModelController().setNumber("furniture_center_z",UnknownVarFromFurnitureLogic_Number_6,true);
         object.getModelController().setNumberArray("furniture_allowed_directions",_directions,true);
         object.getModelController().setNumber("furniture_alpha_multiplier",1);
      }
      
      protected function getAdClickUrl(param1:IRoomObjectModelController) : String
      {
         return param1.getString("furniture_ad_url");
      }
      
      protected function handleAdClick(param1:int, param2:String, param3:String) : void
      {
         if(eventDispatcher != null)
         {
            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_FURNI_CLICK",object));
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc5_:RoomObjectEvent = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc4_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:String = getAdClickUrl(_loc4_);
         switch(param1.type)
         {
            case "mouseMove":
               if(eventDispatcher != null)
               {
                  _loc5_ = new RoomObjectMouseEvent("ROE_MOUSE_MOVE",object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                  (_loc5_ as RoomObjectMouseEvent).localX = param1.localX;
                  (_loc5_ as RoomObjectMouseEvent).localY = param1.localY;
                  (_loc5_ as RoomObjectMouseEvent).spriteOffsetX = param1.spriteOffsetX;
                  (_loc5_ as RoomObjectMouseEvent).spriteOffsetY = param1.spriteOffsetY;
                  eventDispatcher.dispatchEvent(_loc5_);
               }
               break;
            case "rollOver":
               if(!_mouseOver)
               {
                  if(eventDispatcher != null && _loc3_ != null && _loc3_.indexOf("http") == 0)
                  {
                     eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_TOOLTIP_SHOW",object));
                  }
                  if(eventDispatcher != null)
                  {
                     _loc5_ = new RoomObjectMouseEvent("ROE_MOUSE_ENTER",object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                     (_loc5_ as RoomObjectMouseEvent).localX = param1.localX;
                     (_loc5_ as RoomObjectMouseEvent).localY = param1.localY;
                     (_loc5_ as RoomObjectMouseEvent).spriteOffsetX = param1.spriteOffsetX;
                     (_loc5_ as RoomObjectMouseEvent).spriteOffsetY = param1.spriteOffsetY;
                     eventDispatcher.dispatchEvent(_loc5_);
                  }
                  _mouseOver = true;
               }
               break;
            case "rollOut":
               if(_mouseOver)
               {
                  if(eventDispatcher != null && _loc3_ != null && _loc3_.indexOf("http") == 0)
                  {
                     eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_TOOLTIP_HIDE",object));
                  }
                  if(eventDispatcher != null)
                  {
                     _loc5_ = new RoomObjectMouseEvent("ROE_MOUSE_LEAVE",object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                     (_loc5_ as RoomObjectMouseEvent).localX = param1.localX;
                     (_loc5_ as RoomObjectMouseEvent).localY = param1.localY;
                     (_loc5_ as RoomObjectMouseEvent).spriteOffsetX = param1.spriteOffsetX;
                     (_loc5_ as RoomObjectMouseEvent).spriteOffsetY = param1.spriteOffsetY;
                     eventDispatcher.dispatchEvent(_loc5_);
                  }
                  _mouseOver = false;
               }
               break;
            case "doubleClick":
               useObject();
               break;
            case "click":
               if(eventDispatcher != null)
               {
                  _loc5_ = new RoomObjectMouseEvent("ROE_MOUSE_CLICK",object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                  (_loc5_ as RoomObjectMouseEvent).localX = param1.localX;
                  (_loc5_ as RoomObjectMouseEvent).localY = param1.localY;
                  (_loc5_ as RoomObjectMouseEvent).spriteOffsetX = param1.spriteOffsetX;
                  (_loc5_ as RoomObjectMouseEvent).spriteOffsetY = param1.spriteOffsetY;
                  eventDispatcher.dispatchEvent(_loc5_);
               }
               if(eventDispatcher != null && _loc3_ != null && _loc3_.indexOf("http") == 0)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_TOOLTIP_HIDE",object));
               }
               if(eventDispatcher != null && _loc3_ != null)
               {
                  handleAdClick(object.getId(),object.getType(),_loc3_);
               }
               if(eventDispatcher != null && object != null && contextMenu != null)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_OPEN_FURNI_CONTEXT_MENU",object));
               }
               break;
            case "mouseDown":
               if(eventDispatcher != null)
               {
                  _loc5_ = new RoomObjectMouseEvent("ROE_MOUSE_DOWN",object,param1.eventId,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                  eventDispatcher.dispatchEvent(_loc5_);
               }
         }
      }
      
      override public function useObject() : void
      {
         var _loc2_:IRoomObjectModelController = null;
         var _loc1_:String = null;
         if(object != null)
         {
            _loc2_ = object.getModel() as IRoomObjectModelController;
            if(_loc2_ != null)
            {
               _loc1_ = getAdClickUrl(_loc2_);
               if(eventDispatcher != null && _loc1_ != null && _loc1_.length > 0)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_FURNI_DOUBLE_CLICK",object,null,_loc1_));
               }
            }
            if(eventDispatcher != null)
            {
               if(widget != null)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_OPEN_WIDGET",object));
               }
               eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object));
            }
         }
      }
      
      private function handleDataUpdateMessage(param1:RoomObjectDataUpdateMessage) : void
      {
         var _loc2_:IRoomObjectModelController = object.getModelController();
         object.setState(param1.state,0);
         if(_loc2_ != null)
         {
            if(param1.data != null)
            {
               param1.data.writeRoomObjectModel(_loc2_);
            }
            if(!isNaN(param1.extra))
            {
               _loc2_.setString("furniture_extras",String(param1.extra));
               _loc2_.setNumber("furniture_extra",param1.extra);
            }
            _loc2_.setNumber("furniture_state_update_time",lastUpdateTime);
         }
      }
      
      private function handleHeightUpdateMessage(param1:RoomObjectHeightUpdateMessage) : void
      {
         var _loc2_:IRoomObjectModelController = object.getModelController();
         if(_loc2_ != null)
         {
            _loc2_.setNumber("furniture_size_z",param1.height);
         }
      }
      
      private function handleItemDataUpdateMessage(param1:RoomObjectItemDataUpdateMessage) : void
      {
         var _loc2_:IRoomObjectModelController = object.getModelController();
         if(_loc2_ != null)
         {
            _loc2_.setString("furniture_itemdata",param1.itemData);
         }
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc5_:IVector3d = null;
         var _loc2_:IVector3d = null;
         var _loc7_:String = null;
         var _loc8_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc8_ != null)
         {
            handleDataUpdateMessage(_loc8_);
            return;
         }
         var _loc4_:RoomObjectHeightUpdateMessage = param1 as RoomObjectHeightUpdateMessage;
         if(_loc4_ != null)
         {
            handleHeightUpdateMessage(_loc4_);
            return;
         }
         var _loc6_:RoomObjectItemDataUpdateMessage = param1 as RoomObjectItemDataUpdateMessage;
         if(_loc6_ != null)
         {
            handleItemDataUpdateMessage(_loc6_);
            return;
         }
         _mouseOver = false;
         if(param1.dir != null && param1.loc != null)
         {
            if(!(param1 is RoomObjectMoveUpdateMessage))
            {
               _loc5_ = object.getDirection();
               _loc2_ = object.getLocation();
               if(_loc5_ != null && _loc5_.x != param1.dir.x && UnknownVarFromFurnitureLogic_Boolean_1 && _loc2_ != null && _loc2_.x == param1.loc.x && _loc2_.y == param1.loc.y && _loc2_.z == param1.loc.z)
               {
                  UnknownVarFromFurnitureLogic_Int_1 = 1;
                  _storedRotateMessage = new RoomObjectUpdateMessage(param1.loc,param1.dir);
                  param1 = null;
               }
            }
            else if(param1.dir != null)
            {
               object.setDirection(param1.dir);
            }
            UnknownVarFromFurnitureLogic_Boolean_1 = true;
         }
         var _loc3_:RoomObjectSelectedMessage = param1 as RoomObjectSelectedMessage;
         if(contextMenu != null && _loc3_ != null && eventDispatcher != null && object != null)
         {
            _loc7_ = _loc3_.selected ? "ROWRE_OPEN_FURNI_CONTEXT_MENU" : "ROWRE_CLOSE_FURNI_CONTEXT_MENU";
            eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent(_loc7_,object));
         }
         super.processUpdateMessage(param1);
      }
      
      override protected function getLocationOffset() : IVector3d
      {
         if(UnknownVarFromFurnitureLogic_Int_1 > 0)
         {
            UnknownVarFromFurnitureLogic_Vector3d_1.x = 0;
            UnknownVarFromFurnitureLogic_Vector3d_1.y = 0;
            if(UnknownVarFromFurnitureLogic_Int_1 <= 8 / 2)
            {
               UnknownVarFromFurnitureLogic_Vector3d_1.z = 0.0625 * UnknownVarFromFurnitureLogic_Int_1;
            }
            else if(UnknownVarFromFurnitureLogic_Int_1 <= 8)
            {
               if(_storedRotateMessage)
               {
                  super.processUpdateMessage(_storedRotateMessage);
                  _storedRotateMessage = null;
               }
               UnknownVarFromFurnitureLogic_Vector3d_1.z = 0.0625 * (8 - UnknownVarFromFurnitureLogic_Int_1);
            }
            return UnknownVarFromFurnitureLogic_Vector3d_1;
         }
         return null;
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(UnknownVarFromFurnitureLogic_Int_1 > 0)
         {
            UnknownVarFromFurnitureLogic_Int_1++;
            if(UnknownVarFromFurnitureLogic_Int_1 > 8)
            {
               UnknownVarFromFurnitureLogic_Int_1 = 0;
            }
         }
      }
      
      override public function tearDown() : void
      {
         if(widget != null && object.getModelController().getNumber("furniture_real_room_object") == 1)
         {
            eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_CLOSE_WIDGET",object));
         }
         super.tearDown();
      }
   }
}


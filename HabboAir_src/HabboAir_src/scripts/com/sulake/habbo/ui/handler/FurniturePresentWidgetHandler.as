package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.events.RoomSessionPresentEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class FurniturePresentWidgetHandler implements IRoomWidgetHandler, UnknownIHabboRoom1
   {
      private static const UnknownConstFromFurniturePresentWidgetHandler_String_1:String = "floor";
      
      private static const TYPE_WALLPAPER:String = "wallpaper";
      
      private static const TYPE_LANDSCAPE:String = "landscape";
      
      private static const TYPE_POSTER:String = "poster";
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromFurniturePresentWidgetHandler_Int_1:int = -1;
      
      private var _name:String = "";
      
      public function FurniturePresentWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_PRESENT_WIDGET";
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_PRESENT","RWPOM_OPEN_PRESENT"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:RoomWidgetFurniToWidgetMessage = null;
         var _loc3_:IRoomObject = null;
         var _loc13_:IRoomObjectModel = null;
         var _loc12_:String = null;
         var _loc8_:String = null;
         var _loc14_:String = null;
         var _loc11_:int = 0;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc10_:UnknownHabboRoom1 = null;
         var _loc2_:RoomWidgetPresentDataUpdateEvent = null;
         var _loc6_:* = false;
         var _loc9_:RoomWidgetPresentOpenMessage = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_PRESENT":
               _loc4_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc3_ = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.id,_loc4_.category);
               if(_loc3_ != null)
               {
                  _loc13_ = _loc3_.getModel();
                  if(_loc13_ != null)
                  {
                     UnknownVarFromFurniturePresentWidgetHandler_Int_1 = _loc4_.id;
                     _loc12_ = _loc13_.getString("furniture_data");
                     if(_loc12_ == null)
                     {
                        _loc12_ = "";
                     }
                     _loc8_ = _loc13_.getString("furniture_purchaser_name");
                     _loc14_ = _loc13_.getString("furniture_purchaser_figure");
                     _loc11_ = _loc13_.getNumber("furniture_type_id");
                     _loc5_ = _loc13_.getString("furniture_extras");
                     _loc7_ = 32;
                     _loc10_ = _container.roomEngine.getFurnitureImage(_loc11_,new Vector3d(180),_loc7_,null,0,_loc5_);
                     _loc6_ = _loc13_.getNumber("furniture_trusted_sender") == 1;
                     _loc2_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_PACKAGEINFO",_loc4_.id,_loc12_,_container.isOwnerOfFurniture(_loc3_),_loc10_.data,_loc8_,_loc14_,false,false,_loc6_);
                     _container.events.dispatchEvent(_loc2_);
                  }
               }
               break;
            case "RWPOM_OPEN_PRESENT":
               _loc9_ = param1 as RoomWidgetPresentOpenMessage;
               if(_loc9_.objectId != UnknownVarFromFurniturePresentWidgetHandler_Int_1)
               {
                  return null;
               }
               if(_container != null)
               {
                  if(_container.roomSession != null)
                  {
                     _container.roomSession.sendPresentOpenMessage(_loc9_.objectId);
                  }
                  if(_container.roomEngine != null)
                  {
                     _container.roomEngine.changeObjectModelData(_container.roomEngine.activeRoomId,_loc9_.objectId,10,"furniture_disable_picking_animation",1);
                  }
               }
               break;
         }
         return null;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || _container == null)
         {
            return;
         }
         var _loc3_:RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_IMAGE",0,_name,false,param2);
         _container.events.dispatchEvent(_loc3_);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSPE_PRESENT_OPENED"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc13_:RoomSessionPresentEvent = null;
         var _loc3_:IFurnitureData = null;
         var _loc5_:* = null;
         var _loc10_:RoomWidgetPresentDataUpdateEvent = null;
         var _loc2_:Boolean = false;
         var _loc11_:IRoomObject = null;
         var _loc6_:IProductData = null;
         var _loc14_:String = null;
         var _loc4_:String = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc12_:PetFigureData = null;
         var _loc16_:int = 0;
         var _loc7_:int = 0;
         var _loc15_:UnknownHabboRoom1 = null;
         if(param1 == null)
         {
            return;
         }
         if(_container != null && _container.events != null && param1 != null)
         {
            var _loc17_:* = param1.type;
            if("RSPE_PRESENT_OPENED" === _loc17_)
            {
               _loc13_ = param1 as RoomSessionPresentEvent;
               if(_loc13_ != null)
               {
                  _name = "";
                  _loc5_ = null;
                  if(_loc13_.itemType == "s")
                  {
                     _loc3_ = _container.sessionDataManager.getFloorItemData(_loc13_.classId);
                  }
                  else if(_loc13_.itemType == "i")
                  {
                     _loc3_ = _container.sessionDataManager.getWallItemData(_loc13_.classId);
                  }
                  _loc2_ = false;
                  if(_loc13_.placedInRoom)
                  {
                     _loc11_ = _container.roomEngine.getRoomObject(_container.roomSession.roomId,_loc13_.placedItemId,10);
                     if(_loc11_ != null)
                     {
                        _loc2_ = _container.isOwnerOfFurniture(_loc11_);
                     }
                  }
                  switch(_loc13_.itemType)
                  {
                     case "i":
                        if(_loc3_ != null)
                        {
                           switch(_loc3_.className)
                           {
                              case "floor":
                                 _loc10_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_FLOOR",0,_container.localization.getLocalization("inventory.furni.item.floor.name"),_loc2_,null);
                                 break;
                              case "landscape":
                                 _loc10_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_LANDSCAPE",0,_container.localization.getLocalization("inventory.furni.item.landscape.name"),_loc2_,null);
                                 break;
                              case "wallpaper":
                                 _loc10_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_WALLPAPER",0,_container.localization.getLocalization("inventory.furni.item.wallpaper.name"),_loc2_,null);
                                 break;
                              case "poster":
                                 _loc14_ = _loc13_.productCode;
                                 _loc4_ = null;
                                 if(_loc14_.indexOf("poster") == 0)
                                 {
                                    _loc8_ = int(_loc14_.replace("poster",""));
                                    _loc4_ = String(_loc8_);
                                 }
                                 _loc5_ = _container.roomEngine.getWallItemIcon(_loc13_.classId,this,_loc4_);
                                 _loc6_ = _container.sessionDataManager.getProductData(_loc14_);
                                 if(_loc6_ != null)
                                 {
                                    _name = _loc6_.name;
                                 }
                                 else if(_loc3_ != null)
                                 {
                                    _name = _loc3_.localizedName;
                                 }
                                 if(_loc5_ != null)
                                 {
                                    _loc10_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS",0,_name,_loc2_,_loc5_.data);
                                 }
                                 break;
                              default:
                                 _loc5_ = _container.roomEngine.getWallItemIcon(_loc13_.classId,this);
                                 if(_loc3_ != null)
                                 {
                                    _name = _loc3_.localizedName;
                                 }
                                 if(_loc5_ != null)
                                 {
                                    _loc10_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS",0,_name,_loc2_,_loc5_.data);
                                 }
                           }
                        }
                        break;
                     case "h":
                        _loc10_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_CLUB",0,_container.localization.getLocalization("widget.furni.present.hc"),false,null);
                        break;
                     default:
                        if(_loc13_.placedItemType == "p")
                        {
                           _loc9_ = _loc13_.petFigureString;
                           if(_loc9_ != null && _loc9_.length > 0)
                           {
                              _loc12_ = new PetFigureData(_loc9_);
                              _loc16_ = 2;
                              _loc7_ = 64;
                              if(_loc12_.typeId == 15)
                              {
                                 _loc7_ = 32;
                              }
                              _loc15_ = _container.roomEngine.getPetImage(_loc12_.typeId,_loc12_.paletteId,_loc12_.color,new Vector3d(_loc16_ * 45),_loc7_,this,true,0,_loc12_.customParts);
                              if(_loc15_ != null)
                              {
                                 _loc5_ = _loc15_;
                              }
                           }
                        }
                        if(_loc5_ == null)
                        {
                           _loc5_ = _container.roomEngine.getFurnitureImage(_loc13_.classId,new Vector3d(90),64,this);
                        }
                        _loc6_ = _container.sessionDataManager.getProductData(_loc13_.productCode);
                        if(_loc6_ != null)
                        {
                           _name = _loc6_.name;
                        }
                        else if(_loc3_ != null)
                        {
                           _name = _loc3_.localizedName;
                        }
                        if(_loc5_ != null)
                        {
                           _loc10_ = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS",0,_name,_loc2_,_loc5_.data);
                        }
                  }
                  if(_loc10_ != null)
                  {
                     _loc10_.classId = _loc13_.classId;
                     _loc10_.itemType = _loc13_.itemType;
                     _loc10_.placedItemId = _loc13_.placedItemId;
                     _loc10_.placedInRoom = _loc13_.placedInRoom;
                     _loc10_.placedItemType = _loc13_.placedItemType;
                     _container.events.dispatchEvent(_loc10_);
                  }
               }
            }
         }
      }
      
      public function update() : void
      {
      }
   }
}


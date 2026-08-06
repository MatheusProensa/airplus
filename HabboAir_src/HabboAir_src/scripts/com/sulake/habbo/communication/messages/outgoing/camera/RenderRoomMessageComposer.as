package com.sulake.habbo.communication.messages.outgoing.camera
{
   import com.sulake.core.communication.encryption.CryptoTools;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.communication.messages.outgoing.camera.json.JsonMaskDrawingData;
   import com.sulake.habbo.communication.messages.outgoing.camera.json.JsonPlaneDrawingData;
   import com.sulake.habbo.communication.messages.outgoing.camera.json.JsonPoint;
   import com.sulake.habbo.communication.messages.outgoing.camera.json.JsonTextureColumnData;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.room.object.visualization.IRoomObjectSprite_1;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   [SecureSWF(rename="true")]
   public class RenderRoomMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRenderRoomMessageComposer_Array_1:Array;
      
      private var UnknownVarFromRenderRoomMessageComposer_String_1:String;
      
      private var UnknownVarFromRenderRoomMessageComposer_String_2:String;
      
      private var UnknownVarFromRenderRoomMessageComposer_String_3:String = "[]";
      
      private var roomId:int;
      
      private var zoomLevel:int = 1;
      
      private var topSecurityLevel:int;
      
      private var time:Number;
      
      protected var UnknownVarFromRenderRoomMessageComposer_Array_2:Array = [];
      
      public function RenderRoomMessageComposer(param1:Array, param2:String, param3:String, param4:int, param5:int)
      {
         super();
         this.UnknownVarFromRenderRoomMessageComposer_Array_1 = getRoomPlanesDataArray(param1);
         this.UnknownVarFromRenderRoomMessageComposer_String_1 = param2;
         this.UnknownVarFromRenderRoomMessageComposer_String_2 = param3;
         this.roomId = param4;
         this.topSecurityLevel = param5;
         time = new Date().getTime();
      }
      
      private static function planesString() : String
      {
         return StringUtil.makeMagicString(142,178,155,183,194,196,168,157,195,152,143,163,197,154,200,148,158,148,200);
      }
      
      private static function spritesString() : String
      {
         return StringUtil.makeMagicString(113,119,172,167,152,139,154,118,141,140,125,169,152,119,168,165,129,146);
      }
      
      private static function modifiersString() : String
      {
         return StringUtil.makeMagicString(129,188,141,133,186,137,164,132,160,132,185,134,168,183,162,149,181,135);
      }
      
      private static function filtersString() : String
      {
         return StringUtil.makeMagicString(131,190,163,186,162,159,146,177,172,172,132,136,170,186,164,151,164);
      }
      
      private static function roomIdString() : String
      {
         return StringUtil.makeMagicString(122,181,177,127,144,130,147,129,125,157,126,145,142,145,170);
      }
      
      private static function zoomString() : String
      {
         return StringUtil.makeMagicString(126,132,128,180,166,134,158,167,151,148,133,132,181,159,146,158,159);
      }
      
      private static function statusString() : String
      {
         return StringUtil.makeMagicString(118,124,120,172,157,164,171,145,167,143,139,173,154,159,141,134,170);
      }
      
      private static function timestampString() : String
      {
         return StringUtil.makeMagicString(137,178,196,192,164,143,165,144,193,158,164,155,143,144,163,191,160,153,149,173,169,173,195);
      }
      
      private static function checksumString() : String
      {
         return StringUtil.makeMagicString(120,179,124,161,132,139,150,176,139,145,157,141,169,127,152,175,153,140,156,143);
      }
      
      private static function jsonEndString() : String
      {
         return StringUtil.makeMagicString(136,148,159,145,168);
      }
      
      private static function deflate(param1:String) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         _loc2_.compress("zlib");
         return _loc2_;
      }
      
      public function addEffectData(param1:String) : void
      {
         this.UnknownVarFromRenderRoomMessageComposer_String_3 = param1;
      }
      
      public function setZoom(param1:int) : void
      {
         this.zoomLevel = param1;
      }
      
      public function compressData() : void
      {
         var timeLastDigits:int;
         var status:int;
         var check:int;
         var bytes:ByteArray;
         var checksum:int;
         var deflatedMsg:ByteArray;
         var roomPlanesDataJsonObj:String = JSON.stringify(UnknownVarFromRenderRoomMessageComposer_Array_1,function(param1:Object, param2:Object):*
         {
            if(param1 == "masks" && param2.length == 0)
            {
               return undefined;
            }
            return param2;
         });
         var dataStrJsonObj:String = planesString() + roomPlanesDataJsonObj + spritesString() + UnknownVarFromRenderRoomMessageComposer_String_1 + modifiersString() + UnknownVarFromRenderRoomMessageComposer_String_2 + filtersString() + UnknownVarFromRenderRoomMessageComposer_String_3 + roomIdString() + roomId;
         if(zoomLevel != 1)
         {
            dataStrJsonObj += zoomString() + zoomLevel;
         }
         timeLastDigits = time % 100;
         time -= timeLastDigits;
         status = time / 100 % 23 + topSecurityLevel;
         dataStrJsonObj += statusString() + status;
         check = dataStrJsonObj.length;
         check = (check + time / 100 * 17) % 1493;
         bytes = CryptoTools.stringToByteArray(dataStrJsonObj);
         checksum = CryptoTools.fletcher100(bytes,check,roomId);
         dataStrJsonObj += timestampString() + (time + checksum);
         dataStrJsonObj += checksumString() + (timeLastDigits + 13) * (check + 29) + jsonEndString();
         deflatedMsg = deflate(dataStrJsonObj);
         UnknownVarFromRenderRoomMessageComposer_Array_2 = [deflatedMsg];
      }
      
      protected function getRoomPlanesDataArray(param1:Array) : Array
      {
         var _loc11_:JsonPlaneDrawingData = null;
         var _loc6_:* = undefined;
         var _loc4_:Array = null;
         var _loc10_:Array = null;
         var _loc3_:Array = null;
         var _loc8_:Array = null;
         var _loc7_:int = 0;
         var _loc13_:Array = null;
         var _loc2_:JsonTextureColumnData = null;
         var _loc9_:Array = [];
         for each(var _loc14_ in param1)
         {
            _loc11_ = new JsonPlaneDrawingData();
            _loc11_.z = _loc14_.z;
            _loc6_ = _loc14_.cornerPoints;
            _loc11_.addCornerPoint(_loc6_[0].x,_loc6_[0].y);
            _loc11_.addCornerPoint(_loc6_[1].x,_loc6_[1].y);
            _loc11_.addCornerPoint(_loc6_[2].x,_loc6_[2].y);
            _loc11_.addCornerPoint(_loc6_[3].x,_loc6_[3].y);
            _loc11_.color = _loc14_.color;
            _loc4_ = _loc14_.maskAssetNames;
            _loc10_ = _loc14_.maskAssetLocations;
            _loc3_ = _loc14_.maskAssetFlipHs;
            _loc8_ = _loc14_.maskAssetFlipVs;
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               _loc11_.addMask(new JsonMaskDrawingData(_loc4_[_loc7_],new JsonPoint(_loc10_[_loc7_].x,_loc10_[_loc7_].y),_loc3_[_loc7_],_loc8_[_loc7_]));
               _loc7_++;
            }
            _loc11_.setBottomAligned(_loc14_.isBottomAligned());
            _loc13_ = _loc14_.assetNameColumns;
            if(_loc13_.length != 0)
            {
               for each(var _loc5_ in _loc13_)
               {
                  _loc2_ = new JsonTextureColumnData();
                  for each(var _loc12_ in _loc5_)
                  {
                     _loc2_.addAssetName(_loc12_);
                  }
                  _loc11_.addTexCol(_loc2_);
               }
            }
            _loc9_.push(_loc11_);
         }
         return _loc9_;
      }
      
      public function isSendable() : Boolean
      {
         if(UnknownVarFromRenderRoomMessageComposer_Array_2.length == 0)
         {
            compressData();
         }
         return true;
      }
      
      public function getMessageArray() : Array
      {
         if(UnknownVarFromRenderRoomMessageComposer_Array_2.length == 0)
         {
            throw new Exception("Render room message sending attempt before packData() is called.");
         }
         return UnknownVarFromRenderRoomMessageComposer_Array_2;
      }
      
      public function dispose() : void
      {
         UnknownVarFromRenderRoomMessageComposer_Array_2 = [];
      }
   }
}


package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class SlideObjectBundleMessageParser implements IMessageParser
   {
      private var _id:int;
      
      private var _objectList:Array;
      
      private var _avatar:SlideObjectMessageData = null;
      
      public function SlideObjectBundleMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get avatar() : SlideObjectMessageData
      {
         return _avatar;
      }
      
      public function get objectList() : Array
      {
         return _objectList;
      }
      
      public function flush() : Boolean
      {
         _id = -1;
         _avatar = null;
         _objectList = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc14_:int = 0;
         var _loc7_:SlideObjectMessageData = null;
         var _loc2_:Vector3d = null;
         var _loc9_:Vector3d = null;
         var _loc12_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc10_:Number = param1.readInteger();
         var _loc11_:Number = param1.readInteger();
         var _loc5_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         var _loc8_:int = param1.readInteger();
         _objectList = [];
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc14_ = param1.readInteger();
            _loc12_ = Number(param1.readString());
            _loc3_ = Number(param1.readString());
            _loc2_ = new Vector3d(_loc10_,_loc11_,_loc12_);
            _loc9_ = new Vector3d(_loc5_,_loc4_,_loc3_);
            _loc7_ = new SlideObjectMessageData(_loc14_,_loc2_,_loc9_);
            _objectList.push(_loc7_);
            _loc6_++;
         }
         _id = param1.readInteger();
         if(!param1.bytesAvailable)
         {
            return true;
         }
         var _loc13_:int;
         switch(_loc13_ = param1.readInteger())
         {
            case 0:
               break;
            case 1:
               _loc14_ = param1.readInteger();
               _loc12_ = Number(param1.readString());
               _loc3_ = Number(param1.readString());
               _loc2_ = new Vector3d(_loc10_,_loc11_,_loc12_);
               _loc9_ = new Vector3d(_loc5_,_loc4_,_loc3_);
               _avatar = new SlideObjectMessageData(_loc14_,_loc2_,_loc9_,"mv");
               break;
            case 2:
               _loc14_ = param1.readInteger();
               _loc12_ = Number(param1.readString());
               _loc3_ = Number(param1.readString());
               _loc2_ = new Vector3d(_loc10_,_loc11_,_loc12_);
               _loc9_ = new Vector3d(_loc5_,_loc4_,_loc3_);
               _avatar = new SlideObjectMessageData(_loc14_,_loc2_,_loc9_,"sld");
               break;
            default:
               Logger.log("** Incompatible character movetype!");
         }
         return true;
      }
   }
}


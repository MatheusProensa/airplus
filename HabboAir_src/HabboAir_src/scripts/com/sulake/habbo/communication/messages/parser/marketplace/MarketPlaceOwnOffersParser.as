package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
   import com.sulake.habbo.communication.messages.parser.room.engine.UnknownHabboCommunicationMessagesParserRoomEngine1;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.UnknownHabboRoomObjectData1;
   
   [SecureSWF(rename="true")]
   public class MarketPlaceOwnOffersParser implements IMessageParser
   {
      private const UnknownConstFromMarketPlaceOwnOffersParser_Int_1:int = 500;
      
      private const UnknownConstFromMarketPlaceOwnOffersParser_Int_2:int = 2;
      
      private const UnknownConstFromMarketPlaceOwnOffersParser_Int_3:int = 3;
      
      private var _offers:Array;
      
      private var _creditsWaiting:int;
      
      public function MarketPlaceOwnOffersParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc12_:int = 0;
         var _loc14_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:IStuffData = null;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc13_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:Number = NaN;
         var _loc3_:MarketPlaceOffer = null;
         _offers = [];
         var _loc5_:String = "";
         _creditsWaiting = param1.readInteger();
         var _loc8_:int = param1.readInteger();
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc5_ = "";
            _loc9_ = null;
            _loc12_ = param1.readInteger();
            _loc14_ = param1.readInteger();
            _loc2_ = param1.readInteger();
            if(_loc2_ == 1 || _loc2_ == 4)
            {
               _loc4_ = param1.readInteger();
               _loc9_ = UnknownHabboCommunicationMessagesParserRoomEngine1.parseStuffData(param1);
               if(_loc2_ == 4)
               {
                  param1.readBoolean();
                  _loc2_ = 1;
               }
            }
            else if(_loc2_ == 2)
            {
               _loc4_ = param1.readInteger();
               _loc5_ = param1.readString();
            }
            else if(_loc2_ == 3)
            {
               _loc4_ = param1.readInteger();
               _loc9_ = UnknownHabboRoomObjectData1.getStuffDataWrapperForType(0);
               _loc9_.uniqueSerialNumber = param1.readInteger();
               _loc9_.uniqueSeriesSize = param1.readInteger();
               _loc2_ = 1;
            }
            _loc10_ = param1.readInteger();
            _loc7_ = param1.readInteger();
            _loc13_ = param1.readInteger();
            _loc11_ = NaN;
            if(_loc14_ == 2 || _loc14_ == 3)
            {
               _loc11_ = param1.readLong();
            }
            _loc3_ = new MarketPlaceOffer(_loc12_,_loc4_,_loc2_,_loc5_,_loc9_,_loc10_,_loc14_,_loc7_,_loc13_,-1,_loc11_);
            if(_loc6_ < 500)
            {
               _offers.push(_loc3_);
            }
            _loc6_++;
         }
         return true;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get creditsWaiting() : int
      {
         return _creditsWaiting;
      }
   }
}


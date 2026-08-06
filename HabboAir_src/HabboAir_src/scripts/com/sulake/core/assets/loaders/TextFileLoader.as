package com.sulake.core.assets.loaders
{
   import com.probertson.utils.UnknownProbertsonUtils1;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class TextFileLoader extends BinaryFileLoader implements ICachedAssetLoader
   {
      public function TextFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super(param1,param2,param3);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++_retries <= UnknownVarFromUnknownCoreAssetsLoaders1_Int_1)
            {
               try
               {
                  UnknownVarFromBinaryFileLoader_URLLoader_1.close();
               }
               catch(e:Error)
               {
               }
               UnknownVarFromBinaryFileLoader_URLLoader_1.load(new URLRequest(_url + (_url.indexOf("?") == -1 ? "?" : "&") + "retry=" + _retries));
               return true;
            }
         }
         return false;
      }
      
      override protected function loadEventHandler(param1:Event) : void
      {
         if(param1.type == "complete")
         {
            unCompress();
         }
         super.loadEventHandler(param1);
      }
      
      private function unCompress() : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:UnknownProbertsonUtils1 = null;
         var _loc1_:String = "";
         if(UnknownVarFromBinaryFileLoader_URLLoader_1.data is ByteArray)
         {
            _loc2_ = UnknownVarFromBinaryFileLoader_URLLoader_1.data as ByteArray;
            if(_loc2_.length == 0)
            {
               _loc1_ = "";
            }
            else
            {
               try
               {
                  _loc3_ = new UnknownProbertsonUtils1();
                  _loc1_ = _loc3_.uncompressToByteArray(_loc2_).toString();
               }
               catch(error:IllegalOperationError)
               {
                  _loc2_.position = 0;
                  _loc1_ = _loc2_.readUTFBytes(_loc2_.length);
               }
            }
            _loc2_.position = 0;
         }
         else
         {
            _loc1_ = UnknownVarFromBinaryFileLoader_URLLoader_1.data as String;
         }
         UnknownVarFromBinaryFileLoader_URLLoader_1.data = _loc1_;
      }
   }
}


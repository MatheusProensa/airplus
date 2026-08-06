package com.sulake.habbo.room.object.visualization.furniture
{
   import adobe.serialization.json.JSONDecoder;
   import com.sulake.habbo.room.object.visualization.data.ExtraDataManager;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class FurnitureExternalImageVisualization extends ExternalIsometricImageFurniVisualization
   {
      private var UnknownVarFromFurnitureExternalImageVisualization_Boolean_1:Boolean;
      
      private var UnknownVarFromFurnitureExternalImageVisualization_String_1:String;
      
      private var _extraDataUrl:String;
      
      private var _libraryAssetNameForSprite:String;
      
      private var UnknownVarFromFurnitureExternalImageVisualization_Boolean_2:Boolean = false;
      
      private var UnknownVarFromFurnitureExternalImageVisualization_String_2:String = "";
      
      private var _externalImageUUID:String;
      
      public function FurnitureExternalImageVisualization()
      {
         super();
         hasOutline = true;
      }
      
      override public function setExternalBaseUrls(param1:String, param2:String, param3:Boolean) : void
      {
         UnknownVarFromFurnitureExternalImageVisualization_String_1 = param1;
         _extraDataUrl = param2;
         UnknownVarFromFurnitureExternalImageVisualization_Boolean_1 = param3;
      }
      
      override protected function getThumbnailURL() : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!object || UnknownVarFromFurnitureExternalImageVisualization_String_1 == "disabled" || _libraryAssetNameForSprite == "REJECTED")
         {
            return null;
         }
         if(_libraryAssetNameForSprite)
         {
            return _libraryAssetNameForSprite;
         }
         var _loc1_:String = object.getModel().getString("furniture_data");
         if(_loc1_ == null)
         {
            return null;
         }
         try
         {
            if(object.getType().indexOf("external_image_wallitem_poster") != -1)
            {
               UnknownVarFromFurnitureExternalImageVisualization_String_2 = "";
            }
            else
            {
               UnknownVarFromFurnitureExternalImageVisualization_String_2 = "postcards/selfie/";
            }
            _loc2_ = getJsonValue(_loc1_,"id",null);
            if(_loc2_ && _loc2_.length > 0)
            {
               if(!UnknownVarFromFurnitureExternalImageVisualization_Boolean_2)
               {
                  _externalImageUUID = _loc2_;
                  UnknownVarFromFurnitureExternalImageVisualization_Boolean_2 = true;
                  if(UnknownVarFromFurnitureExternalImageVisualization_Boolean_1)
                  {
                     ExtraDataManager.requestExtraDataUrl(this);
                  }
                  else
                  {
                     loadExtraData(_loc2_);
                  }
               }
               return null;
            }
            _loc3_ = getJsonValue(_loc1_,"w","url");
            _loc3_ = buildThumbnailUrl(_loc3_,UnknownVarFromFurnitureExternalImageVisualization_String_2);
         }
         catch(error:Error)
         {
            return null;
         }
         _libraryAssetNameForSprite = _loc3_;
         return _loc3_;
      }
      
      public function getExternalImageUUID() : String
      {
         return _externalImageUUID;
      }
      
      private function buildThumbnailUrl(param1:String, param2:String) : String
      {
         if(param1 == "REJECTED")
         {
            return param1;
         }
         if(param1.indexOf("http") != 0)
         {
            param1 = UnknownVarFromFurnitureExternalImageVisualization_String_1 + param2 + param1;
         }
         param1 = param1.replace(".png","_small.png");
         if(param1.indexOf(".png") == -1)
         {
            param1 += "_small.png";
         }
         return param1;
      }
      
      private function getJsonValue(param1:String, param2:String, param3:String) : String
      {
         var _loc5_:Object = new JSONDecoder(param1,false).getValue();
         var _loc4_:String = _loc5_[param2];
         if(_loc4_ == null && param3 != null)
         {
            _loc4_ = _loc5_[param3];
         }
         return _loc4_;
      }
      
      private function loadExtraData(param1:String) : void
      {
         var _loc3_:String = _extraDataUrl + param1;
         var _loc2_:URLLoader = new URLLoader(new URLRequest(_loc3_));
         _loc2_.addEventListener("complete",onExtraDataLoaded);
         _loc2_.addEventListener("ioError",onExtraDataError);
         UnknownVarFromFurnitureExternalImageVisualization_Boolean_2 = true;
      }
      
      private function onExtraDataError(param1:Event) : void
      {
         Logger.log("Extra data failed to load " + param1.toString());
      }
      
      private function onExtraDataLoaded(param1:Event) : void
      {
         var _loc2_:String = URLLoader(param1.target).data;
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc3_:String = getJsonValue(_loc2_,"w","url");
         _libraryAssetNameForSprite = buildThumbnailUrl(_loc3_,UnknownVarFromFurnitureExternalImageVisualization_String_2);
      }
      
      public function onUrlFromExtraDataService(param1:String) : void
      {
         _libraryAssetNameForSprite = buildThumbnailUrl(param1,UnknownVarFromFurnitureExternalImageVisualization_String_2);
      }
      
      public function getExtraDataUrl() : String
      {
         return _extraDataUrl;
      }
      
      override public function dispose() : void
      {
         ExtraDataManager.furnitureDisposed(this);
         super.dispose();
      }
      
      override public function getImage(param1:int, param2:int) : BitmapData
      {
         if(!assetCollection)
         {
            return new BitmapData(1,1,true,0);
         }
         var _loc3_:String = getFullThumbnailAssetName(param2,32);
         if(assetCollection.getAsset(_loc3_) == null && object)
         {
            _loc3_ = object.getType() + "_icon_a";
         }
         if(assetCollection.getAsset(_loc3_) == null)
         {
            return new BitmapData(1,1,true,0);
         }
         var _loc4_:Object = assetCollection.getAsset(_loc3_).asset.content;
         if(!_loc4_)
         {
            return new BitmapData(1,1,true,0);
         }
         return (_loc4_ as BitmapData).clone();
      }
      
      override protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         return _libraryAssetNameForSprite;
      }
   }
}


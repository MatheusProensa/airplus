package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.IAnimationManager;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.avatar.structure.AvatarStructureDownload;
   import com.sulake.habbo.avatar.structure.IFigureSetData;
   import com.sulake.habbo.avatar.structure.IStructureData;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.utils.FigureDataContainer;
   import com.sulake.iid.*;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class AvatarRenderManager extends Component implements IAvatarRenderManager
   {
      private static const BUILT_IN_ANIMATION_ASSET_NAMES:Array = ["dance_sixseven_animation"];
      
      private const AVATAR_PLACEHOLDER_FIGURE:String = "hd-99999-99999";
      
      private var UnknownVarFromAvatarRenderManager_AssetAliasCollection_1:AssetAliasCollection;
      
      private var UnknownVarFromAvatarRenderManager_AvatarStructure_1:AvatarStructure;
      
      private var _mode:String;
      
      private var _petImageListeners:Map;
      
      private var UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1:AvatarAssetDownloadManager;
      
      private var UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1:EffectAssetDownloadManager;
      
      private var UnknownVarFromAvatarRenderManager_AvatarFigureContainer_1:AvatarFigureContainer;
      
      private var UnknownVarFromAvatarRenderManager_AvatarFigureContainer_2:AvatarFigureContainer;
      
      private var UnknownVarFromAvatarRenderManager_Boolean_1:Boolean = false;
      
      private var UnknownVarFromAvatarRenderManager_Boolean_2:Boolean = false;
      
      private var UnknownVarFromAvatarRenderManager_Boolean_3:Boolean = false;
      
      private var _isReady:Boolean = false;
      
      private var _inNuxFlow:Boolean;
      
      private var UnknownVarFromAvatarRenderManager_Boolean_4:Boolean;
      
      private var UnknownVarFromAvatarRenderManager_Boolean_5:Boolean;
      
      private var UnknownVarFromAvatarRenderManager_Array_1:Array = [];
      
      private var _activeImages:Array = [];
      
      public function AvatarRenderManager(param1:IComponent_2, param2:uint, param3:IAssetLibraryCollection, param4:Boolean = false)
      {
         _inNuxFlow = param4;
         param2 |= 4;
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return _inNuxFlow ? super.dependencies : super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }])]);
      }
      
      override protected function initComponent() : void
      {
         _mode = "component";
         _petImageListeners = new Map();
         var _loc1_:XML = <actions><action  id="Default" precedence="1000" state="std" main="1" isdefault="1" geometrytype="vertical" activepartset="figure" assetpartdefinition="std"/>	<!-- baked in actions for snowwar -->
				<action  id="SnowWarRun" state="swrun" precedence="104" main="1" geometrytype="vertical" activepartset="snowwarrun" assetpartdefinition="swrun" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieFront" state="swdiefront" precedence="105" main="1" geometrytype="swhorizontal" activepartset="snowwardiefront" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieBack" state="swdieback" precedence="106" main="1" geometrytype="swhorizontal" activepartset="snowwardieback" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarPick" state="swpick" precedence="107" main="1" geometrytype="vertical" activepartset="snowwarpick" assetpartdefinition="swpick" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarThrow" state="swthrow" precedence="108" main="1" geometrytype="vertical" activepartset="snowwarthrow" assetpartdefinition="swthrow" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx.174,fx175,fx176,dance"/>
			</actions>;
         UnknownVarFromAvatarRenderManager_AvatarStructure_1 = new AvatarStructure(this);
         UnknownVarFromAvatarRenderManager_AvatarStructure_1.initGeometry(assets.hasAsset("HabboAvatarGeometry") ? assets.getAssetByName("HabboAvatarGeometry").content as XML : null);
         UnknownVarFromAvatarRenderManager_AvatarStructure_1.initPartSets(assets.hasAsset("HabboAvatarPartSets") ? assets.getAssetByName("HabboAvatarPartSets").content as XML : null);
         UnknownVarFromAvatarRenderManager_AvatarStructure_1.initActions(assets,_loc1_);
         UnknownVarFromAvatarRenderManager_AvatarStructure_1.initAnimation(assets.hasAsset("HabboAvatarAnimation") ? assets.getAssetByName("HabboAvatarAnimation").content as XML : null);
         UnknownVarFromAvatarRenderManager_AvatarStructure_1.initFigureData(assets.hasAsset("HabboAvatarFigure") ? assets.getAssetByName("HabboAvatarFigure").content as XML : null);
         UnknownVarFromAvatarRenderManager_AssetAliasCollection_1 = new AssetAliasCollection(this,context.assets as AssetLibraryCollection);
         UnknownVarFromAvatarRenderManager_AssetAliasCollection_1.init();
         checkIfReady();
      }
      
      private function requestActions() : void
      {
         var _loc3_:String = getProperty("flash.dynamic.avatar.download.url") + "HabboAvatarActions.xml";
         var _loc1_:URLRequest = new URLRequest(_loc3_);
         var _loc2_:AssetLoaderStruct = assets.loadAssetFromFile("HabboAvatarActions",_loc1_,"text/xml");
         _loc2_.addEventListener("AssetLoaderEventComplete",onAvatarActionsLoaded);
      }
      
      private function onAvatarActionsLoaded(param1:Event = null) : void
      {
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1 == null)
         {
            return;
         }
         var _loc2_:XML = <actions><action  id="Default" precedence="1000" state="std" main="1" isdefault="1" geometrytype="vertical" activepartset="figure" assetpartdefinition="std"/>	<!-- baked in actions for snowwar -->
				<action  id="SnowWarRun" state="swrun" precedence="104" main="1" geometrytype="vertical" activepartset="snowwarrun" assetpartdefinition="swrun" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieFront" state="swdiefront" precedence="105" main="1" geometrytype="swhorizontal" activepartset="snowwardiefront" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieBack" state="swdieback" precedence="106" main="1" geometrytype="swhorizontal" activepartset="snowwardieback" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarPick" state="swpick" precedence="107" main="1" geometrytype="vertical" activepartset="snowwarpick" assetpartdefinition="swpick" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarThrow" state="swthrow" precedence="108" main="1" geometrytype="vertical" activepartset="snowwarthrow" assetpartdefinition="swthrow" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx.174,fx175,fx176,dance"/>
			</actions>;
         UnknownVarFromAvatarRenderManager_AvatarStructure_1.updateActions(assets.hasAsset("HabboAvatarActions") ? assets.getAssetByName("HabboAvatarActions").content as XML : _loc2_);
         registerBuiltInAnimations();
         UnknownVarFromAvatarRenderManager_Boolean_4 = true;
         checkIfReady();
      }
      
      private function registerBuiltInAnimations() : void
      {
         var _loc1_:* = null;
         var _loc2_:XML = null;
         for each(_loc1_ in BUILT_IN_ANIMATION_ASSET_NAMES)
         {
            if(assets.hasAsset(_loc1_))
            {
               _loc2_ = assets.getAssetByName(_loc1_).content as XML;
               if(_loc2_ != null)
               {
                  UnknownVarFromAvatarRenderManager_AvatarStructure_1.registerAnimation(_loc2_);
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1 != null)
         {
            UnknownVarFromAvatarRenderManager_AvatarStructure_1.dispose();
            UnknownVarFromAvatarRenderManager_AvatarStructure_1 = null;
         }
         if(UnknownVarFromAvatarRenderManager_AssetAliasCollection_1 != null)
         {
            UnknownVarFromAvatarRenderManager_AssetAliasCollection_1.dispose();
            UnknownVarFromAvatarRenderManager_AssetAliasCollection_1 = null;
         }
         if(_petImageListeners)
         {
            _petImageListeners.dispose();
            _petImageListeners = null;
         }
         if(UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1)
         {
            UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.removeEventListener("complete",onAvatarAssetsDownloadManagerReady);
            UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.dispose();
            UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1 = null;
         }
         if(UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1)
         {
            UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1.removeEventListener("complete",onAvatarAssetsDownloadManagerReady);
            UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1.dispose();
            UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1 = null;
         }
         UnknownVarFromAvatarRenderManager_Array_1 = null;
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:AvatarStructureDownload = null;
         requestActions();
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1 != null)
         {
            _loc4_ = getProperty("external.figurepartlist.txt");
            if(assets.hasAsset(_loc4_))
            {
               assets.removeAsset(assets.getAssetByName(_loc4_));
            }
            _loc3_ = new AvatarStructureDownload(assets,_loc4_,UnknownVarFromAvatarRenderManager_AvatarStructure_1.figureData as IStructureData);
            _loc3_.addEventListener("AVATAR_STRUCTURE_DONE",onFigureDataDownloadDone);
            if(UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1 == null)
            {
               _loc2_ = getProperty("flash.dynamic.avatar.download.configuration");
               _loc6_ = getProperty("flash.dynamic.avatar.download.url");
               _loc7_ = getProperty("flash.dynamic.avatar.download.name.template");
               UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1 = new AvatarAssetDownloadManager(this,context.assets,_loc2_,_loc6_,UnknownVarFromAvatarRenderManager_AvatarStructure_1,_loc7_);
               UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.addEventListener("complete",onAvatarAssetsDownloadManagerReady);
               UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.addEventListener("LIBRARY_LOADED",onAvatarAssetsLibraryReady);
            }
            if(UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1 == null)
            {
               _loc5_ = getProperty("flash.dynamic.avatar.download.url") + "effectmap.xml";
               _loc6_ = getProperty("flash.dynamic.avatar.download.url");
               _loc7_ = getProperty("flash.dynamic.avatar.download.name.template");
               UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1 = new EffectAssetDownloadManager(context.assets,_loc5_,_loc6_,UnknownVarFromAvatarRenderManager_AvatarStructure_1,_loc7_);
               UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1.addEventListener("complete",onEffectAssetsDownloadManagerReady);
               UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1.addEventListener("LIBRARY_LOADED",onEffectAssetsLibraryReady);
            }
         }
      }
      
      public function onMandatoryLibrariesReady() : void
      {
         UnknownVarFromAvatarRenderManager_Boolean_3 = true;
         checkIfReady();
      }
      
      private function onAvatarAssetsLibraryReady(param1:LibraryLoadedEvent) : void
      {
         UnknownVarFromAvatarRenderManager_AssetAliasCollection_1.onAvatarAssetsLibraryReady(param1.library);
      }
      
      private function onEffectAssetsLibraryReady(param1:LibraryLoadedEvent) : void
      {
         UnknownVarFromAvatarRenderManager_AssetAliasCollection_1.onAvatarAssetsLibraryReady(param1.library);
      }
      
      private function onFigureDataDownloadDone(param1:Event = null) : void
      {
         var _loc2_:ISoundAsset = assets.getAssetByName(getProperty("external.figurepartlist.txt"));
         if(_loc2_)
         {
            assets.removeAsset(_loc2_).dispose();
         }
         UnknownVarFromAvatarRenderManager_Boolean_2 = true;
         UnknownVarFromAvatarRenderManager_AvatarStructure_1.init();
         checkIfReady();
      }
      
      private function onAvatarAssetsDownloadManagerReady(param1:Event = null) : void
      {
         UnknownVarFromAvatarRenderManager_Boolean_1 = true;
         checkIfReady();
      }
      
      private function onEffectAssetsDownloadManagerReady(param1:Event = null) : void
      {
         UnknownVarFromAvatarRenderManager_Boolean_5 = true;
         checkIfReady();
      }
      
      public function get effectMap() : Dictionary
      {
         if(UnknownVarFromAvatarRenderManager_Boolean_5)
         {
            return UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1.map;
         }
         return null;
      }
      
      private function checkIfReady() : void
      {
         if(!_isReady)
         {
            if(UnknownVarFromAvatarRenderManager_Boolean_3 && UnknownVarFromAvatarRenderManager_Boolean_1 && UnknownVarFromAvatarRenderManager_Boolean_2 && UnknownVarFromAvatarRenderManager_Boolean_4 && UnknownVarFromAvatarRenderManager_Boolean_5)
            {
               _isReady = true;
               this.events.dispatchEvent(new Event("AVATAR_RENDER_READY"));
               purgeInitDownloadBuffer();
            }
         }
      }
      
      private function purgeInitDownloadBuffer() : void
      {
         var _loc1_:UnknownIHabboAvatar1 = null;
         if(UnknownVarFromAvatarRenderManager_Array_1)
         {
            for each(var _loc2_ in UnknownVarFromAvatarRenderManager_Array_1)
            {
               _loc1_ = _loc2_[1];
               if(_loc1_ != null && !_loc1_.disposed)
               {
                  UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.loadFigureSetData(_loc2_[0] as IAvatarFigureContainer,_loc1_);
               }
            }
            UnknownVarFromAvatarRenderManager_Array_1 = [];
         }
      }
      
      public function createFigureContainer(param1:String) : IAvatarFigureContainer
      {
         return new AvatarFigureContainer(param1);
      }
      
      public function isFigureReady(param1:IAvatarFigureContainer) : Boolean
      {
         if(!UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1)
         {
            return false;
         }
         return UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.isReady(param1);
      }
      
      public function downloadFigure(param1:IAvatarFigureContainer, param2:UnknownIHabboAvatar1) : void
      {
         if(!UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1)
         {
            UnknownVarFromAvatarRenderManager_Array_1.push([param1,param2]);
            return;
         }
         UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.loadFigureSetData(param1,param2);
      }
      
      public function createAvatarImage(param1:String, param2:String, param3:String = null, param4:UnknownIHabboAvatar1 = null, param5:IAvatarImage_1 = null) : IAvatarImage_2
      {
         var _loc6_:AvatarImage = null;
         var _loc7_:PlaceholderAvatarImage = null;
         var _loc8_:AvatarFigureContainer = new AvatarFigureContainer(param1);
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1 == null)
         {
            UnknownVarFromAvatarRenderManager_Array_1.push([_loc8_,param4]);
            return null;
         }
         if(!UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1 && _mode != "local_only")
         {
            UnknownVarFromAvatarRenderManager_Array_1.push([_loc8_,param4]);
            return null;
         }
         if(param3)
         {
            validateAvatarFigure(_loc8_,param3);
         }
         if(_mode == "local_only" || UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.isReady(_loc8_))
         {
            _loc6_ = new AvatarImage(UnknownVarFromAvatarRenderManager_AvatarStructure_1,UnknownVarFromAvatarRenderManager_AssetAliasCollection_1,_loc8_,param2,UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1,param5);
            _activeImages.push(_loc6_);
            return _loc6_;
         }
         if(!UnknownVarFromAvatarRenderManager_AvatarFigureContainer_1)
         {
            UnknownVarFromAvatarRenderManager_AvatarFigureContainer_1 = new AvatarFigureContainer("hd-99999-99999");
         }
         _loc7_ = new PlaceholderAvatarImage(UnknownVarFromAvatarRenderManager_AvatarStructure_1,UnknownVarFromAvatarRenderManager_AssetAliasCollection_1,UnknownVarFromAvatarRenderManager_AvatarFigureContainer_1,param2,UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1);
         UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.loadFigureSetData(_loc8_,param4);
         return _loc7_;
      }
      
      public function createBlockedAvatarImage(param1:String, param2:String) : IAvatarImage_2
      {
         if(!UnknownVarFromAvatarRenderManager_AvatarFigureContainer_2)
         {
            UnknownVarFromAvatarRenderManager_AvatarFigureContainer_2 = new AvatarFigureContainer("hd-99999-99999");
         }
         return new BlockedAvatarImage(UnknownVarFromAvatarRenderManager_AvatarStructure_1,UnknownVarFromAvatarRenderManager_AssetAliasCollection_1,UnknownVarFromAvatarRenderManager_AvatarFigureContainer_2,param2,UnknownVarFromAvatarRenderManager_EffectAssetDownloadManager_1);
      }
      
      public function unregisterImage(param1:AvatarImage) : void
      {
         var _loc2_:int = int(_activeImages.indexOf(param1));
         if(_loc2_ >= 0)
         {
            _activeImages.splice(_loc2_,1);
         }
      }
      
      public function getFigureData() : IFigureSetData
      {
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1)
         {
            return UnknownVarFromAvatarRenderManager_AvatarStructure_1.figureData;
         }
         return null;
      }
      
      public function isValidFigureSetForGender(param1:int, param2:String) : Boolean
      {
         var _loc3_:IFigureSetData = getFigureData();
         var _loc4_:IFigurePartSet = _loc3_.getFigurePartSet(param1);
         if(_loc4_ != null)
         {
            if(_loc4_.gender.toUpperCase() == "U" || _loc4_.gender.toUpperCase() == param2.toUpperCase())
            {
               return true;
            }
         }
         return false;
      }
      
      public function getFigureStringWithFigureIds(param1:String, param2:String, param3:Vector.<int>) : String
      {
         var _loc6_:FigureDataContainer = new FigureDataContainer();
         _loc6_.loadAvatarData(param1,param2);
         var _loc4_:Vector.<IFigurePartSet> = resolveFigureSets(param3);
         for each(var _loc5_ in _loc4_)
         {
            _loc6_.savePartData(_loc5_.type,_loc5_.id,_loc6_.getColourIds(_loc5_.type));
         }
         return _loc6_.getFigureString();
      }
      
      private function resolveFigureSets(param1:Vector.<int>) : Vector.<IFigurePartSet>
      {
         var _loc4_:IFigurePartSet = null;
         var _loc2_:IFigureSetData = getFigureData();
         var _loc3_:Vector.<IFigurePartSet> = new Vector.<IFigurePartSet>(0);
         for each(var _loc5_ in param1)
         {
            _loc4_ = _loc2_.getFigurePartSet(_loc5_);
            if(_loc4_ != null)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function getItemIds() : Array
      {
         return UnknownVarFromAvatarRenderManager_AvatarStructure_1.getItemIds();
      }
      
      public function getAnimationManager() : IAnimationManager
      {
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1)
         {
            return UnknownVarFromAvatarRenderManager_AvatarStructure_1.animationManager;
         }
         return null;
      }
      
      public function getMandatoryAvatarPartSetIds(param1:String, param2:int) : Array
      {
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1)
         {
            return UnknownVarFromAvatarRenderManager_AvatarStructure_1.getMandatorySetTypeIds(param1,param2);
         }
         return null;
      }
      
      public function getAssetByName(param1:String) : ISoundAsset
      {
         return UnknownVarFromAvatarRenderManager_AssetAliasCollection_1.getAssetByName(param1);
      }
      
      public function get mode() : String
      {
         return _mode;
      }
      
      public function set mode(param1:String) : void
      {
         _mode = param1;
      }
      
      public function injectFigureData(param1:XML) : void
      {
         if(UnknownVarFromAvatarRenderManager_AvatarStructure_1 != null)
         {
            UnknownVarFromAvatarRenderManager_AvatarStructure_1.injectFigureData(param1);
         }
      }
      
      private function validateAvatarFigure(param1:AvatarFigureContainer, param2:String) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc3_:IFigureSetData = null;
         var _loc7_:IFigurePartSet = null;
         var _loc11_:ISetType = null;
         var _loc4_:IFigurePartSet = null;
         var _loc9_:IFigurePartSet = null;
         if(!UnknownVarFromAvatarRenderManager_AvatarStructure_1)
         {
            ErrorReportStorage.addDebugData("AvatarRenderManager","validateAvatarFigure: structure is null!");
         }
         var _loc10_:int = 2;
         var _loc6_:Array = UnknownVarFromAvatarRenderManager_AvatarStructure_1.getMandatorySetTypeIds(param2,_loc10_);
         if(_loc6_)
         {
            _loc3_ = UnknownVarFromAvatarRenderManager_AvatarStructure_1.figureData;
            if(!_loc3_)
            {
               ErrorReportStorage.addDebugData("AvatarRenderManager","validateAvatarFigure: figureData is null!");
            }
            for each(var _loc8_ in _loc6_)
            {
               if(!param1.hasPartType(_loc8_))
               {
                  _loc7_ = UnknownVarFromAvatarRenderManager_AvatarStructure_1.getDefaultPartSet(_loc8_,param2);
                  if(_loc7_)
                  {
                     param1.updatePart(_loc8_,_loc7_.id,[0]);
                     _loc5_ = true;
                  }
               }
               else
               {
                  _loc11_ = _loc3_.getSetType(_loc8_);
                  if(!_loc11_)
                  {
                     ErrorReportStorage.addDebugData("AvatarRenderManager","validateAvatarFigure: setType is null!");
                  }
                  if(_loc11_)
                  {
                     _loc4_ = _loc11_.getPartSet(param1.getPartSetId(_loc8_));
                     if(!_loc4_)
                     {
                        _loc9_ = UnknownVarFromAvatarRenderManager_AvatarStructure_1.getDefaultPartSet(_loc8_,param2);
                        if(_loc9_)
                        {
                           param1.updatePart(_loc8_,_loc9_.id,[0]);
                           _loc5_ = true;
                        }
                     }
                  }
               }
            }
         }
         return !_loc5_;
      }
      
      public function resolveClubLevel(param1:IAvatarFigureContainer, param2:String, param3:Array = null) : int
      {
         return 0;
      }
      
      public function resetAssetManager() : void
      {
         UnknownVarFromAvatarRenderManager_AssetAliasCollection_1.reset();
      }
      
      public function resetAllCaches() : void
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _activeImages)
         {
            if(_loc1_ && !_loc1_.disposed)
            {
               _loc1_.resetCache();
               _loc2_.push(_loc1_);
            }
         }
         _activeImages = _loc2_;
      }
      
      public function purgeAssets() : void
      {
         if(UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1)
         {
            UnknownVarFromAvatarRenderManager_AvatarAssetDownloadManager_1.purge();
         }
      }
      
      public function get isReady() : Boolean
      {
         return _isReady;
      }
   }
}


<resource schema="usgs_wms">
	<meta name="title">USGS WMS</meta>
	<meta name="description">Astrogeology WMS Map Layers</meta>
	<meta name="creationDate">2016-05-24T00:00:00</meta>
	<meta name="subject">USGS WMS</meta>
	<meta name="creator.name">Mikhail Minin</meta>
	<meta name="contact.name">Mikhail Minin</meta>
	<meta name="contact.email">m.minin@jacobs-university.de</meta>
	<meta name="instrument"></meta>
	<meta name="facility"></meta>
	<meta name="source">http://astrowebmaps.wr.usgs.gov/webmapatlas/Layers/maps.html</meta>
	<meta name="contentLevel"></meta>
	<meta name="type">Catalog</meta>
	<meta name="coverage">
		<meta name="Profile">Solar System</meta>
	</meta>

<!-- METADATA COMPLETE -->

	<table id="epn_core" onDisk="true">
		<mixin processing_level="4" spatial_frame_type="body">//epntap2#table</mixin>
<!--		<meta name="info" infoName="SERVICE_PROTOCOL" infoValue="0.3">EPN-TAP</meta> -->
		<meta name="description">Catalog of USGS WMS</meta>
		<stc>
			Polygon ICRS [s_region]
		</stc>
<!-- MAKE OPTIONAL COLUMNS: -->
		<column name="access_url" type="text" ucd="meta.ref.url;meta.file" verbLevel="1" description="URL of the data file, 
			case sensitive. If present, next 2 paramenters must be present."/> 
		<column name="access_format" type="text" ucd="meta.code.mime" verbLevel="1" description="File format type"/> 
		<column name="access_estsize" type="integer" unit="kbyte" ucd="phys.size;meta.file" verbLevel="1" description="Estimate file size in kbyte (with this spelling)"/> 
		<column name="thumbnail_url" type="text" ucd="meta.ref.url;meta.preview " verbLevel="1" description="URL of a thumbnail image with predefined size (png ~200 pix, for use in a client only)"/> 
<!--		<column name="file_name" type="text" ucd="meta.id;meta.file" verbLevel="1" description="Name of the data file only, case sensitive"/> -->

<!-- MAKE more OPTIONAL COLUMNS, for example: -->
<!--
		<column name="access_url" type="text" ucd="meta.ref.url;meta.file" verbLevel="1" description="URL of the data file, 
			case sensitive. If present, next 2 paramenters must be present."/> 
-->
<!-- MAKE NON-STANDARD COLUMNS, for example: -->
<!--
		<column name="counter" type="text" ucd="meta.note;meta.main" tablehead="value" verbLevel="1" description="non standard" />
-->
		<publish />
	</table>
<!-- TABLE COMPLETE -->

	<data id="import">
		<sources>data/usgsWMS06.csv</sources>
		<csvGrammar>
			<rowfilter procDef="//products#define">
				<bind name="table">"schema.epn_core"</bind>
			</rowfilter>
		</csvGrammar>
		<make table="epn_core">
			<rowmaker idmaps="*">
				<var key="granule_uid" source="LayerTitle" />
				<var key="granule_gid" source="System" />
				<var key="obs_id" source="LayerLayerName" />

				<var key="dataproduct_type">"im"</var>

				<var key="target_name" source="Object" />
				<var key="target_class" source="TargetClass" />



				<var key="c1min">0</var>
				<var key="c1max">360</var>

				<var key="c2min">-90</var>
				<var key="c2max">90</var>

				<var key="spatial_frame_type">"body"</var>

		<var key="instrument_host_name" source="InstrumentHostName" />
		<var key="instrument_name" source="InstrumentName" />

				<var key="processing_level">4</var>

				<var key="access_url" source="OnlineResource" />
				<var key="access_format">"application/x-wms"</var>
				<var key="access_estsize">20</var>
				<var key="thumbnail_url">@access_url + "service=WMS&amp;version=1.3.0&amp;request=GetMap&amp;LAYERS=" + @obs_id + "&amp;CRS=EPSG:4326&amp;BBOX=-90,0,90,360&amp;FORMAT=image/jpeg&amp;WIDTH=360&amp;HEIGHT=180"</var>
				<var key="access_url">@access_url + "service=WMS&amp;request=GetCapabilities"</var>
<!--				<var key="file_name">"mapserv.jpeg"</var> -->


				<apply procDef="//epntap2#populate" name="fillepn">
					<bind name="granule_uid">@granule_uid</bind>
					<bind name="granule_gid">@granule_gid</bind>
					<bind name="obs_id">@obs_id</bind>

					<bind name="dataproduct_type">@dataproduct_type</bind>

					<bind name="target_name">@target_name</bind>
					<bind name="target_class">@target_class</bind>



					<bind name="c1min">@c1min</bind>
					<bind name="c1max">@c1max</bind>

					<bind name="c2min">@c2min</bind>
					<bind name="c2max">@c2max</bind>



<bind name="access_format">@access_format</bind>
<bind name="spatial_frame_type">@spatial_frame_type</bind>
<bind name="instrument_host_name">@instrument_host_name</bind>


				</apply>
			</rowmaker>
		</make>
	</data>
</resource>

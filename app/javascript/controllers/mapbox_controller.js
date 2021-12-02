import { Controller } from "@hotwired/stimulus";
import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }
  static targets = ["selected"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/rocketeer006/ckwddb9v736k815lcivknqckp'
    });
    this._addMarkersToMap();
    this._fitMapToMarkers();
    this.map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));
    this.map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        // When active the map will receive updates to the device's location as it changes.
        trackUserLocation: true,
        // Draw an arrow next to the location dot to indicate which direction the device is heading.
        showUserHeading: true
      })
      );
    // this.markersValue.forEach((marker) => {
    //   marker.getElement.addEventListener((event) => {
    //     console.log(event.currentTarget)
    //   })
      // marker.addEventListener("click", (event) => {
      //   console.log(event.currentTarget)
      // })
    // })

  }
  _addMarkersToMap() {
    if (this.markersValue.length === 1) {
      this.markersValue.forEach((marker) => {
        const customMarker = document.createElement('div');
        customMarker.className = 'active_marker';
        customMarker.dataset.mapboxTarget = 'selected';
        customMarker.dataset.action = 'click->mapbox#changeImage';
        customMarker.style.backgroundImage = `url('${marker.active_image_url}')`;
        customMarker.style.backgroundSize = 'cover';
        customMarker.style.width = '27px';
        customMarker.style.height = '35px';
          new mapboxgl.Marker(customMarker)
            .setLngLat([marker.lng, marker.lat])
            .addTo(this.map)
      })
    } else {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup({className:'coolpopup', maxWidth: '325px'}).setHTML(marker.info_window);
      const customMarker = document.createElement('div');
      if (marker.availability === 0) {
        customMarker.className = 'active_marker';
        customMarker.dataset.action = 'click->mapbox#changeImage';
        customMarker.dataset.mapboxTarget = 'selected';
        customMarker.style.backgroundImage = `url('${marker.active_image_url}')`;
        customMarker.style.backgroundSize = 'cover';
        customMarker.style.width = '27px';
        customMarker.style.height = '35px';
      } else {
        customMarker.className = 'inactive_marker';
        customMarker.style.backgroundImage = `url('${marker.inactive_image_url}')`;
        customMarker.dataset.action = 'click->mapbox#changeImage';
        customMarker.dataset.mapboxTarget = 'selected';
        customMarker.style.backgroundSize = 'cover';
        customMarker.style.width = '27px';
        customMarker.style.height = '35px';
      }


      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
        // .addEventListener("click", (event) => {
        //   console.log("hello")
        // });
    })};
  }
  _fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };
  changeImage() {
    this.selectedTargets.forEach((marker) => {
      marker.classList.remove('selected')
    })
    event.target.classList.add('selected')
  }
};

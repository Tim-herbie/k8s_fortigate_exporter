> [!CAUTION]
> ## This repository has been archived
> Since I have switched to a different firewall vendor, this repository has been archived.
>

<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]




<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Tim-herbie/k8s_fortigate_exporter">
    <img src="./images/Logo_TimHerbert.jpeg" alt="Logo" width="180" height="180">
  </a>

  <h3 align="center">Fortigate Prometheus exporter for Kubernetes</h3>

  <p align="center">
    This repository demonstrates how to deploy the prometheus exporter on Kubernetes to monitor a fortigate firewall. 
    <br />
    <br />
    ·
    <a href="https://github.com/Tim-herbie/k8s_fortigate_exporter/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/Tim-herbie/k8s_fortigate_exporter/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#projects">Projects</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project provides a streamlined and efficient way to deploy a [FortiGate Prometheus exporter](https://github.com/bluecmd/fortigate_exporter) for your Kubernetes environment to monitor a fortigate firewall.
> **Info: It is possible to monitor multiple fortigates and also only specific metrics** 

Components:
* **[FortiGate Prometheus exporter for Kubernetes](https://github.com/bluecmd/fortigate_exporter)**


<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- GETTING STARTED -->
## Getting Started

The following requirements are necessary to install the project.

### System requirements for installation
- A running Kubernetes cluster
- kubectl installed and configured
- git installed and configured
- makefile installed

### Already installed within your Kubernetes Cluster
- [Prometheus](https://prometheus.io/)

### Fortigate requirements
Please ensure to use a valid and trusted HTTPS server certificate for your firewall.
> **Note: If you are using a self signed certificate, make sure to use this image: `therbert6/fortigate-exporter:0.1-insecure`** 


### Installation

_The deployment is handled by a Makefile._

1. Clone the repo
    ```sh
   git clone https://github.com/Tim-herbie/k8s_fortigate_exporter.git
   ```
2.  Ensure that the following Profile exist on your fortigate. You can create it via CLI **or** UI.
    - Create Access Profile via CLI
        ```
        config system accprofile
            edit "monitor"
                # global scope will fail on non multi-VDOM firewall
                set scope global
                set authgrp read
                # As of FortiOS 6.2.1 it seems `fwgrp-permissions.other` is removed,
                # use 'fwgrp read' to get load balance servers metrics
                set fwgrp custom
                set loggrp custom
                set netgrp custom
                set sysgrp custom
                set vpngrp read
                set wifi read
                # will fail for most recent FortiOS
                set system-diagnostics disable
                config fwgrp-permission
                    set policy read
                    set others read
                end
                config netgrp-permission
                    set cfg read
                    set route-cfg read
                end
                config loggrp-permission
                    set config read
                end
                config sysgrp-permission
                    set cfg read
                end
            next
        end
        ```
    - Create Access Profile via UI

        ![FortiGate Access Profile UI](./images/fortigate-accprofile.png)
3. After that create a new "REST API Admin" under `System/Administrators` and name it something like `prometheus`. **Note the API Key!**
4. You have now completed all preparations! Now it´s time to create the `fortigate.env` file and enter the URL of your firewall and the API Key.
    > **Make sure that you configured your fortigate firewall with a valid certificate** 
    ```yml
    # fortigate.env
    URL=https://fw.example.com
    FORTIGATE_API_TOKEN=my-secure-fortigate-api-token
    ```
5. Deployment
   ```sh
   make all
   ```
   After this you should be able to see some metrics from your fortigate firewall in Prometheus!

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

### Prometheus Metrics
Once the Fortigate Prometheus exporter pod is up and running, you should be able to see the metrics in Prometheus.


<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- CONTACT -->
## Contact

Tim Herbert - info@timherbert.de

Project Link: [https://github.com/Tim-herbie/k8s_fortigate_exporter](https://github.com/Tim-herbie/k8s_fortigate_exporter)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- PROJECTS -->
## Projects

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [PowerDNS for Kubernetes](https://github.com/Tim-herbie/k8s_powerdns)
* [PowerDNS Traefik Sync Tool for Kubernetes](https://github.com/Tim-herbie/k8s_powerdns_traefik_sync)
* [FortiGate Exporter for Kubernetes](https://github.com/Tim-herbie/k8s_fortigate_exporter)
* [KeyCloak for Kubernetes](https://github.com/Tim-herbie/k8s_keycloak)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Tim-herbie/k8s_fortigate_exporter.svg?style=for-the-badge
[contributors-url]: https://github.com/Tim-herbie/k8s_fortigate_exporter/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Tim-herbie/k8s_fortigate_exporter.svg?style=for-the-badge
[forks-url]: https://github.com/Tim-herbie/k8s_fortigate_exporter/network/members
[stars-shield]: https://img.shields.io/github/stars/Tim-herbie/k8s_fortigate_exporter.svg?style=for-the-badge
[stars-url]: https://github.com/Tim-herbie/k8s_fortigate_exporter/stargazers
[issues-shield]: https://img.shields.io/github/issues/Tim-herbie/k8s_fortigate_exporter.svg?style=for-the-badge
[issues-url]: https://github.com/Tim-herbie/k8s_fortigate_exporter/issues
[license-shield]: https://img.shields.io/github/license/Tim-herbie/k8s_fortigate_exporter.svg?style=for-the-badge
[license-url]: https://github.com/Tim-herbie/k8s_fortigate_exporter/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/tim-herbert-cv/
[product-screenshot]: ../k8s_fortigate_exporter/images/PowerDNS.jpg
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
